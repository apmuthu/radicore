<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2013 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

class curl_class {

    // class properties
    var $errors;                // error messages

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function curl_class()
    {
        $this->errors = array();
    } // curl_class

    // ****************************************************************************
    // class methods
    // ****************************************************************************
    function download ($url, $userid=null, $password=null, $curlopt_header=false)
    // download a file from a remote server
    {
        $this->errors = array();

        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 20);
        curl_setopt($ch, CURLOPT_TIMEOUT, 120);
        curl_setopt($ch, CURLOPT_HEADER, $curlopt_header);
        curl_setopt($ch, CURLOPT_ENCODING, '');
        if (!empty($userid)) {
            curl_setopt($ch, CURLOPT_USERPWD, $userid.':'.$password);
        } // if

        $result = curl_exec($ch);

        $error_no  = curl_errno($ch);
        $error_msg = curl_error($ch);
        $getinfo   = curl_getinfo($ch);
        if ($getinfo['http_code'] >= 400) {
            $this->errors[] = 'HTTP response='.$getinfo['http_code'];
        } // if
        if ($err <> 0) {
            $this->errors[] = "CURL Error: $error_no, $error_msg";
        } // if

        curl_close($ch);

        return $result;

    } // download

    // ****************************************************************************
    function upload ($server, $username, $password, $local_file, $remote_file)
    // upload a file to a remote server.
    {
        $this->errors = array();

        $url = "ftp://" .urlencode($username) .":" .urlencode($password) ."@" . $server .'/' .$remote_file;

        if (!$fp = fopen($local_file, 'r')) {
            $this->errors[] = "Cannot open file '$local_file'";
            return false;
        } // if

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_UPLOAD, 1);
        curl_setopt($ch, CURLOPT_INFILE, $fp);
        curl_setopt($ch, CURLOPT_INFILESIZE, filesize($local_file));

        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
        curl_setopt($ch, CURLOPT_FTP_SSL, CURLFTPSSL_TRY);

        $output = curl_exec($ch);

        $error_no  = curl_errno($ch);
        $error_msg = curl_error($ch);
        curl_close($ch);

        fclose($fp);

        if ($error_no <> 0) {
            $this->errors[] = "Cannot send file to '$url'";
            $this->errors[] = "CURL Error: $error_no, $error_msg";
            return false;
        } // if

        return true;

    } // upload

    // ****************************************************************************
    function getErrors ()
    {
        return $this->errors;

    } // getErrors

// ****************************************************************************
} // end curl_class
// ****************************************************************************

?>
