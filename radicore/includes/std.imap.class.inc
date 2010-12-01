<?php

// *****************************************************************************
// Copyright 2010 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

require_once('include.library.inc');

class imap_class
{
    var $mbox;                  // stream which connects to the mailbox
    var $date;                  // returned by imap_check()
    var $driver;                // returned by imap_check()
    var $encoding = 'utf-8';    // output encoding
    var $errors = array();      // array of error messages
    var $headers;               // message headers
    var $mailbox;               // returned by imap_check()
    var $msg_count;             // message count after being opened
    var $msg_no;                // message number (when reading)
    var $recent;                // returned by imap_check()

    // ****************************************************************************
    function imap_class ()
    // class constructor
    {
        return true;

    } // imap_class

    // ****************************************************************************
    function open ($mailbox, $user, $password)
    // open the mailbox and obtain message count, et cetera
    {
        if (!$this->mbox = imap_open($mailbox, $user, $password)) {
            $this->errors[] = "Could not open mailbox";
            return false;
        } // if

        $object = imap_check($this->mbox);
        $this->date      = $object->Date;
        $this->driver    = $object->Driver;
        $this->mailbox   = $object->Mailbox;
        $this->msg_count = $object->Nmsgs;
        $this->recent    = $object->Recent;

        $this->headers = imap_headers($this->mbox);

        $this->msg_no = 1;  // start reading at first message

        return true;

    } // open

    // ****************************************************************************
    function setEncoding ($encoding)
    // set the output encoding.
    {
        $this->encoding = $encoding;

    } // setEncoding

    // ****************************************************************************
    function readMsg ($msg_no=null, $option=0)
    // read the next message from the mailbox
    // (or a specific message if $msg_no is supplied)
    {
        $message = array();

        if (!empty($msg_no)) {
        	$index = $msg_no;          // read specified message
        } else {
            $index = $this->msg_no;    // read next message
            $this->msg_no++;           // increment message counter
        } // if

        if ($index > $this->msg_count) {
        	return false;
        } // if

        // start with raw header
        $rawHeader = @imap_fetchheader($this->mbox, $index, $option);
        if (!$rawHeader) {
        	return false;
        } // if

        // now get the individual components
        $mailHeader = imap_headerinfo($this->mbox, $index);

        $mailHeader = object2array($mailHeader);

        $message['msg_no']          = (int)$mailHeader['Msgno'];
        $message['raw_header']      = $rawHeader;
        $message['message_id']      = trim($mailHeader['message_id'], '<>');
        if (!empty($mailHeader['in_reply_to'])) {
        	$message['in_reply_to'] = trim($mailHeader['in_reply_to'], '<>');
        } else {
            $message['in_reply_to'] = null;
        } // if
        $message['date']            = date('Y-m-d H:i:s', $mailHeader['udate']);
        $message['from']            = $mailHeader['from']['mailbox'].'@'.$mailHeader['from']['host'];
        $message['from_personal']   = $mailHeader['from']['personal'];

        if (is_int(key($mailHeader['to']))) {
        	// multiple entries supplied
            foreach ($mailHeader['to'] as $key => $value) {
            	$array[$key] = $value['mailbox'].'@'.$value['host'];
            } // foreach
            $message['to']          = implode(', ', $array);
        } else {
            $message['to']          = $mailHeader['to']['mailbox'].'@'.$mailHeader['to']['host'];
        } // if

        if (!empty($mailHeader['cc'])) {
            if (is_int(key($mailHeader['cc']))) {
            	// multiple entries supplied
                foreach ($mailHeader['cc'] as $key => $value) {
                	$array[$key] = $value['mailbox'].'@'.$value['host'];
                } // foreach
                $message['cc']          = implode(', ', $array);
            } else {
                $message['cc']          = $mailHeader['cc']['mailbox'].'@'.$mailHeader['cc']['host'];
            } // if
        } // if

        $message['subject']         = $mailHeader['subject'];
        if (!empty($mailHeader['reply_to'])) {
        	$message['reply_toaddress'] = $mailHeader['reply_to']['mailbox'].'@'.$mailHeader['reply_to']['host'];
        }  else {
            $message['reply_toaddress'] = $message['from'];
        } // if
        $message['size']            = $mailHeader['Size'];

        $htmlmsg     = null;
        $plainmsg    = null;
        $charset     = null;
        $attachments = array();
        $ids         = array();  // content-id for each attachment

        $bodyStruct = imap_fetchstructure($this->mbox, $index);
        if (empty($bodyStruct->parts))  {
            // not multipart, so use 0 as part-number
            $this->_getpart($this->mbox, $index, $bodyStruct, 0, $htmlmsg, $plainmsg, $charset, $attachments, $ids);
        } else {
            // multipart: iterate through each part
            foreach ($bodyStruct->parts as $partno0 => $p) {
                $this->_getpart($this->mbox, $index, $p, $partno0+1, $htmlmsg, $plainmsg, $charset, $attachments, $ids);
            } // foreach
        } // if

        $message['charset']     = $charset;
        $message['text']        = $plainmsg;
        $message['htmlmsg']     = $htmlmsg;
        $message['attachments'] = $attachments;
        $message['content_ids'] = $ids;

        // decode any input
        if (!empty($this->encoding)) {
        	$message['text'] = iconv($charset, $this->encoding, $message['text']);
        } // if

        // deal with any elements which have been MIME encoded
        if (preg_match('/=\?/', $message['subject'])) {
        	$message['subject'] = imap_utf8($message['subject']);
        } // if
        if (preg_match('/=\?/', $message['from'])) {
            $message['from'] = imap_utf8($message['from']);
        } // if
        if (preg_match('/=\?/', $message['from_personal'])) {
            $message['from_personal'] = imap_utf8($message['from_personal']);
        } // if

        if (empty($message['text']) AND !empty($message['htmlmsg'])) {
            // text missing, so use HTML version
            $message['text'] = $this->html2text($message['htmlmsg'], $message['charset']);
        } // if

        return $message;

    } // readMsg

    // ****************************************************************************
    function deleteMsg ($msg_id, $uid=false)
    // mark a message for deletion (done when mailbox is closed)
    {
        $result = imap_delete($this->mbox, $msg_id, $uid);

        return $result;

    } // deleteMsg

    // ****************************************************************************
    function html2text ($input, $charset='iso-8859-1')
    // convert HTML document to plain text.
    {
        $output = $input;

        if (preg_match('/(?<=charset=)[-0-9a-zA-Z]+/i', $input, $regs)) {
        	$charset = $regs[0];
        } // if

        $output = iconv($charset, 'UTF-8//TRANSLIT', $output);

        // convert non-breaking spaces (UTF-8 encoding is 0xC2 0xA0)
        $output = str_replace('&nbsp;', chr(194).chr(160), $output);

    	// remove all line breaks
    	$output = str_replace(array("\r\n", "\r", "\n"), '', $output);

    	// convert all '<BR>' tags to line breaks
    	$output = preg_replace('#(<BR[ ]*[/]?>)#i', "\n", $output);

    	// insert line break after each '</DIV>'
    	$output = preg_replace('#</DIV>#i', "</DIV>\n", $output);

    	// remove or replace all other HTML tags and special characters
    	$output = preg_replace('#<title>.*</title>#i', '', $output);
        $output = strip_tags($output);
    	$output = htmlspecialchars_decode($output, ENT_QUOTES);
        $output = html_entity_decode($output, ENT_QUOTES, 'UTF-8');

        // remove leading/trailing spaces
        $output = trim($output);

        return $output;

    } // html2text

    // ****************************************************************************
    function close ($expunge=false)
    // close the mailbox ('expunge' will delete all messages)
    {
        $result = imap_close($this->mbox, $expunge);

        return $result;

    } // close

    // ****************************************************************************
    function _getpart($mbox, $mid, $p, $partno, &$htmlmsg, &$plainmsg, &$charset, &$attachments, &$ids)
    // $partno = '1', '2', '2.1', '2.1.3', etc if multipart, 0 if not multipart
    {
        if ($partno) {
            $data = imap_fetchbody($mbox, $mid, $partno);  // multipart
        } else {
            $data = imap_body($mbox, $mid);  // not multipart
        } // if

        // part may need to be decoded
        if ($p->encoding==4) {
            $data = quoted_printable_decode($data);
        } elseif ($p->encoding==3) {
            $data = base64_decode($data);
        } // if

        // get parameters such as charset, attachment names, etc.
        $params = array();
        if ($p->ifparameters) {
            foreach ($p->parameters as $x) {
                $params[strtolower($x->attribute)] = $x->value;
            } // foreach
        } // if
        if ($p->ifdparameters) {
            foreach ($p->dparameters as $x) {
                $params[strtolower($x->attribute)] = $x->value;
            } // foreach
        } // if

        // Any part with a filename is an attachment,
        // so an attached text file (type 0) is not mistaken as the message.
        if (!empty($params['filename']) OR !empty($params['name'])) {
            // filename may be given as 'Filename' or 'Name' or both
            if (!empty($params['filename'])) {
            	$filename = $params['filename'];
            } else {
                $filename = $params['name'];
            } // if
            if (preg_match('/=\?/', $filename)) {
                // name is MIME encoded, so decode it
                $filename = imap_utf8($filename);
            } // if
            $attachments[$filename] = $data;  // two files should NOT have the same name
            if (!empty($p->id)) {
            	$ids[$filename] = trim($p->id, '<>');  // provide content-id for this attachment
            } // if

        } elseif ($p->type==0 && $data) {
            // Messages may be split in different parts because of inline attachments,
            // so append parts together with blank row.
            if (strtolower($p->subtype)=='plain') {
                $plainmsg .= trim($data) ."\n\n";
            } else {
                $htmlmsg .= $data ."<br><br>";
            } // if
            $charset = $params['charset'];  // assume all parts are same charset

        } elseif ($p->type==2 && $data) {

            // EMBEDDED MESSAGE
            // Many bounce notifications embed the original message as type 2,
            // but AOL uses type 1 (multipart), which is not handled here.
            // There are no PHP functions to parse embedded messages,
            // so this just appends the raw source to the main message.
            $plainmsg .= trim($data) ."\n\n";
        } // if

        if (!empty($p->parts)) {
            // subpart recursion
            foreach ($p->parts as $partno0 => $p2) {
                $this->_getpart($mbox, $mid, $p2, $partno.'.'.($partno0+1), $htmlmsg, $plainmsg, $charset, $attachments, $ids);
            } // foreach
        } // if

        return;

    } // _getpart

} // class: imap_class

?>
