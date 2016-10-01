<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
// Author:  Tony Marston
// Version: 1.5.0
// Date:    04-01-2012
// *****************************************************************************

// this file contains functions which use PHP's XMLRPC extension

// obtain config details for this installation
$userdata       = array();
$server_options = array();
if (file_exists('config.xmlrpc.inc')) {
	require('config.xmlrpc.inc');
} else {
    require('config.xmlrpc.inc.default');
} // if

// ****************************************************************************
function get_XMLRPC_client ($subject)
// return an object for the XMLRPC client
{
    $object =& RDCsingleton::getInstance('XMLRPC_client');

    $object->subject = $subject;

    //$object->use_curl = true;     // curl or fsockopen

    return $object;

} // get_XMLRPC_client

// ****************************************************************************
class XMLRPC_client
// this is the XML-RPC (Remote Procedure Call) client
{
    var $scheme;
    var $server;
    var $path;
    var $port;
    var $useragent;
    var $action;            // action to be performed
    var $subject;           // subject of the action
    var $request;
    var $requestHdr;        // http header (outbound - may not be available)
    var $response;          // in PHP format
    var $responseXML;       // in XML format
    var $responseHdr;       // http header (inbound - may not be available)
    var $errorCode;
    var $errorMsg;
    var $fatal_error;       // true/false
    var $timeout = 30;      // connection timeout
    var $use_curl = false;  // yes/no

    var $numrows;
    var $pageno;
    var $lastpage;

    // ****************************************************************************
    function __construct ($location=null)
    // constructor for the XMLRPC Client object
    {
        if (!empty($location)) {
        	$result = $this->setLocation($location);
        } // if

        $this->useragent = 'Radicore XMLRPC Client';

        return true;

    } // __construct

    // ****************************************************************************
    function getClassName ()
    // emulates the function within 'std.table.class.inc' by returning the name of
    // the database table on which the method will be performed.
    {
        return $this->subject;

    } // getClassName

    // ****************************************************************************
    function initialise ()
    // set all variables to initial values.
    {
        $this->action  = null;
        $this->request = null;
        $this->response = null;

        $this->errorCode   = null;
        $this->errorMsg    = null;
        $this->fatal_error = false;

        return;

    } // initialise

    // ****************************************************************************
    function setLocation ($location)
    // split the URL into its component parts and store them for later use.
    {
        $bits = parse_url($location);
        if (empty($bits['host'])) {
        	$this->setError(-1, "HOST is missing from input");
        	return false;
        } else {
            $this->server = $bits['host'];
        } // if
        if (empty($bits['path'])) {
        	$this->path = '/';
        } else {
            $this->path = $bits['path'];
        } // if
        if (isset($bits['scheme'])) {
        	$this->scheme = $bits['scheme'];
        } // if
        if (empty($bits['port'])) {
            if (isset($bits['scheme'])) {
            	if ($bits['scheme'] == 'https') {
            		$this->port = 443;
            	} else {
            	    $this->port = 80;
            	} // if
            } // if
        } else {
            $this->port = $bits['port'];
        } // if

        return true;

    } // setLocation

    // ****************************************************************************
    function Request ($method, $params)
    // send a request to the XMLRPC server and receive a response
    {
        if ($this->errorCode) {
            // error found in setLocation()
        	return false;
        } // if

        if (empty($this->server)) {
        	$this->setError(-1, "HOST is missing from input");
        	return false;
        } // if

        // convert request into an XML document (UTF-8 characters will become numeric entities)
        $options = array('encoding' => 'ISO-8859-1');
        $this->request = xmlrpc_encode_request($method, $params, $options);

        // issue the query and obtain a response
        $response = $this->_send($this->server,
                                 $this->path,
                                 $this->port,
                                 $this->request,
                                 $this->useragent,
                                 $this->timeout);

        if (!empty($this->errorCode)) {
            return false;
        } // if

//        $response = <<<EOD
//HTTP/1.1 301 Moved Permanently
//Date: Mon, 23 Aug 2010 09:26:48 GMT
//Server: Apache
//Location: http://www.weddingrings-direct.com/transix/XMLRPC/server.php
//Content-Length: 268
//Connection: close
//Content-Type: text/html; charset=iso-8859-1
//
//<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
//<html><head>
//<title>301 Moved Permanently</title>
//</head><body>
//<h1>Moved Permanently</h1>
//<p>The document has moved <a href="http://www.weddingrings-direct.com/transix/XMLRPC/server.php">here</a>.</p>
//</body></html>
//
//EOD;

        if (preg_match('/^(http)/i', $response)) {
            // strip http headers from the response
    		$pos = strpos($response, "\r\n\r\n");
    		if ($pos === false) {
    		    $this->responseHdr = $response;
    		    $response          = null;
    		} else {
    		    $pos = $pos+4;
    		    $this->responseHdr = substr($response, 0, $pos);
    		    $response          = substr($response, $pos);
    		    if (!preg_match('/^(<\?xml)/i', $response)) {
    		        // does not begin with '<?xml', so something must be wrong
    		        $this->errorCode = 'Server: Invalid Response';
        	        $this->errorMsg  = $response;
                    return false;
    		    } // if
    		} // if
        } else {
            $this->responseHdr = get_headers($this->config['API_Endpoint'], 1);
        } // if

        if (!preg_match('/^(<\?xml)/i', $response)) {
            // does not begin with '<?xml', so something must be wrong
            $this->responseHdr = $response;
    		$response          = null;
        } // if

        $this->responseXML = $response;

        if (empty($response)) {
        	$response['faultCode']   = -9998;
        	$response['faultString'] = 'Error - response from server is empty';
        	if (!empty($this->responseHdr)) {
        		$response['faultString'] .= ': ' .$this->responseHdr;
        	} // if
        } else {
            if (preg_match('/<\?xml.+?\?>/i', $response, $regs)) {
                // convert XML document into either a string or an array
    		    $response = xmlrpc_decode($response);
    		    if (is_array($response)) {
    			    $response = $this->convert_types($response);
    		    } elseif (empty($response)) {
    			    $this->errorCode = 'Server: Invalid Response';
    	            $this->errorMsg  = 'Response is empty';
                    return false;
    		    } // if
            } else {
                $this->errorCode = 'Server: Invalid Response';
                $this->errorMsg  = 'Response is not XML';
                return false;
            } // if
        } // if

        if (is_string($response)) {
        	$result = true;
        } elseif (!xmlrpc_is_fault($response)) {
		    $result = true;
		} else {
            $this->errorCode = $response['faultCode'];
        	$this->errorMsg  = $response['faultString'];
        	$result = false;
        } // if

        $this->response =& $response;

        return $result;

    } // Request

    // ****************************************************************************
    function convert_types ($input)
    // convert any values from 'object' to a proper value
    {
        if (is_int(key($input))) {
            // multiple rows input, so use as-is
			$rowdata  = $input;
			$rowcount = 99;
		} else {
		    // single row input, so set it to row zero
		    $rowdata[0] = $input;
		    $rowcount  = 1;
		} // if

		foreach ($rowdata as $rownum => $data) {
		    if (is_array($data)) {
    			foreach ($data as $fieldname => $fieldvalue) {
                    if (is_object($fieldvalue)) {
                        if ($fieldvalue->xmlrpc_type == 'datetime') {
                        	$data[$fieldname] = date('Y-m-d H:i:s', $fieldvalue->timestamp);
                        } elseif ($fieldvalue->xmlrpc_type == 'base64') {
                            $data[$fieldname] = base64_decode($fieldvalue->base64);
                        } // if
                    } // if
    			} // foreach
		    } // if
			$rowdata[$rownum] = $data;
		} // foreach

		if ($rowcount == 1) {
		    // return a single row
			$output = $rowdata[0];
		} else {
		    // return multiple rows
		    $output = $rowdata;
		} // if

		return $output;

    } // convert_types

    // ****************************************************************************
    function debug ()
    // display info for debugging
    {
        $string = '';

        if (!empty($this->requestHdr)) {
        	$string .= "<p>Request Hdr: <br>" .nl2br($this->requestHdr) ."</p>";
        } // if
        if (!empty($this->request)) {
        	$string .= "<p>Request: <pre>" .htmlspecialchars($this->request) ."</pre></p>";
        } // if
        if (!empty($this->responseHdr)) {
            $string .= "<p>Response Hdr: <br>" .nl2br($this->responseHdr) ."</p>";
        } // if
        if (!empty($this->responseXML)) {
            $string .= "<p>Response: <pre>" .htmlspecialchars($this->responseXML) ."</pre></p>";
        } // if

        return $string;

    } // debug

    // ****************************************************************************
    function log_error ()
    // send a copy of these error details to a log file (or email)
    {
        $mailstring = null;

        echo $this->errorCode .'<br>'.$this->errorMsg.'<br>';

        if (!empty($this->errorMsg)) {
        	$mailstring .= "errorCode: " .$this->errorCode ."\n"
        	              ."errorMsg: " .$this->errorMsg ."\n\n";
        } // if
        if (!empty($this->requestHdr)) {
        	$mailstring .= "Request Hdr:\n" .$this->requestHdr ."\n";
        } // if
        if (!empty($this->request)) {
        	$mailstring .= "Request:\n" .$this->request ."\n";
        } // if
        if (!empty($this->responseHdr)) {
            $mailstring .= "Response Hdr:\n" .$this->responseHdr ."\n";
        } // if
        if (!empty($this->responseXML)) {
            $mailstring .= "Response:\n" .$this->responseXML ."\n";
        } // if

        // obtain backtrace data
        $result = debug_backtrace();
        $trace = null;
        foreach ($result as $level => $string) {
            $trace .= "$level: array =\n";
            if (is_array($string)) {
                $trace = print_Trace($level, $string, $trace);
            } // if
        } // foreach

        // email details to sysadmin
        $headers = "From: XML-RPC Client on {$_SERVER['HTTP_HOST']}\r\n";
        if (defined('ERROR_LOG_MAILTO')) {
        	$to = ERROR_LOG_MAILTO;
		} else {
			$to = $_SERVER['SERVER_ADMIN'];
        } // if
        @error_log("$mailstring\nBacktrace:\n$trace", 1, $to, $headers);

        // append details to error log
        $errorstring = "<h2>" . date('Y-m-d H:i:s') . "</h2>\n";

        $trace = "Backtrace:\n<pre>\n" .$trace ."\n</pre>\n";

        $mailstring = htmlentities($mailstring);
        $mailstring = str_replace(' ', '&nbsp;', $mailstring);
        $mailstring = nl2br($mailstring);

        $logfile = $_SERVER['DOCUMENT_ROOT'] .'/errorlog.html';
        @error_log($errorstring.' '.$mailstring.' '.$trace, 3, $logfile);

        return;

    } // log_error

    // ****************************************************************************
    function getErrorCode ()
    //
    {
        return $this->errorCode;

    } // getErrorCode

    // ****************************************************************************
    function getErrorMessage ()
    //
    {
        return $this->errorMsg;

    } // getErrorMessage

    // ****************************************************************************
    function setError ($faultCode, $faultString)
    //
    {
        $this->errorCode = $faultCode;
        $this->errorMsg  = $faultString;

        return false;

    } // setError

    // ****************************************************************************
    function __call ($name, $args)
    // magic method to satisfy method names which are not actually defined.
    {
        if (preg_match('/^getMany$/i', $name)) $name = 'list';

        $method = $name .'_' .$this->subject;

        if (method_exists($this, $method)) {
        	$response = $this->$method($args);
        } else {
            die("XML-RPC Client: Method '$method' does not exist");
        } // if

        return $response;

    } // __call

    // ****************************************************************************
    function _send($site, $location, $port=null, $request=null, $user_agent=null, $timeout=30)
    // send the request to the server and receive a response.
    {
        if ($this->use_curl) {
        	$response = $this->_send_via_curl($site, $location, $port, $request, $user_agent, $timeout);
        } else {
            $response = $this->_send_via_sockets($site, $location, $port, $request, $user_agent, $timeout);
        } // if

    	return $response;

    } // _send

    // ****************************************************************************
    function _send_via_curl($site, $location, $port=null, $request=null, $user_agent=null, $timeout)
    //
    {
        $url = $site .$location;

        $header[] = "Content-type: text/xml";
        //$header[] = "Content-length: ".strlen($request);
        if (!empty($user_agent)) {
        	$header[] = "User-Agent: ".$user_agent;
        } // if

        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
        curl_setopt($ch, CURLOPT_TIMEOUT, $timeout);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        if (defined('CURLINFO_HEADER_OUT')) {
            curl_setopt($ch, CURLINFO_HEADER_OUT, true);
        } // if
        curl_setopt($ch, CURLOPT_POSTFIELDS, $request);

        $response = curl_exec($ch);
        if ($response === FALSE) {
            $curl_errno = curl_errno($ch);
            $curl_error = curl_error($ch);
        	$response = XMLRPC_fatal_error($curl_errno, $curl_error);
        } // if
        if (defined('CURLINFO_HEADER_OUT')) {
        	$info = curl_getinfo($ch, CURLINFO_HEADER_OUT);
        	$this->requestHdr = $info;
        } // if
        curl_close($ch);

    	return $response;

    } // _send_via_curl

    // ****************************************************************************
    function _send_via_sockets($site, $location, $port=null, $request=null, $user_agent=null, $timeout)
    //
    {
        $protocol = null;
        if (preg_match('/https/i', $this->scheme)) {
            $protocol = 'ssl://';
        } // if
        $errno  = null;
        $errstr = null;
        $conn = fsockopen ($protocol.$site, $port, $errno, $errstr, $timeout);
    	if (!$conn) {
    		$response = $this->setError($errno, $errstr);
    	} else {
    		$this->requestHdr =
    			"POST $location HTTP/1.0\r\n" .
    			"Host: $site\r\n" .
    			"Connection: close\r\n" .
    			($user_agent ? "User-Agent: $user_agent\r\n" : '') .
    			"Content-Type: text/xml\r\n" .
    			"Content-Length: " . strlen($request) . "\r\n\r\n";

    		fputs($conn, $this->requestHdr);
    		fputs($conn, $request);

    		//socket_set_blocking ($conn, false);
    		$response = "";
    		while(!feof($conn)){
    			$response .= fgets($conn, 1024);
    		} // while
    		fclose($conn);
    	} // if

    	return $response;

    } // _send_via_sockets

} // class: XMLRPC_client

// ****************************************************************************
function XMLRPC_errorhandler($faultCode=null, $faultString=null)
// send details of this error back to the XML-RPC client.
// (see 'errorHandler' in error.inc)
{
    if (empty($faultCode)) {
    	$faultCode   = -9999;
    } // if
    if (empty($faultString)) {
    	$faultString = 'XMLRPC Server - unexpected error';
    } // if

    //$array['faultCode']   = $faultCode;
    //$array['faultString'] = $faultString;
    //$xml = xmlrpc_encode($array);

    $xml = <<<EOD
<?xml version="1.0" encoding="UTF-8"?>
<methodResponse>
  <fault>
    <value>
      <struct>
        <member>
          <name>faultCode</name>
          <value><string>{$faultCode}</string></value>
        </member>
        <member>
          <name>faultString</name>
          <value><string>{$faultString}</string></value>
        </member>
      </struct>
    </value>
  </fault>
</methodResponse>

EOD;

    if (defined('XMLRPC_DEBUG')) {
        echo '<pre>';
    	echo htmlspecialchars($xml);
    	echo '</pre>';
    } else {
    	header("Connection: close");
    	header("Content-Type: text/xml");
    	header("Date: " . date("r"));
        echo $xml;
    } // if

} // XMLRPC_errorhandler

// ****************************************************************************
function XMLRPC_fatal_error($faultCode, $faultString)
// return a fatal error to the XML-RPC client
{
//    $response['faultCode'] = $faultCode;
//    $response['faultString'] = $faultString;
//
//	return $response;

    // send error details back to the client
    XMLRPC_errorhandler($faultCode, $faultString);
    exit;

} // XMLRPC_fatal_error

// ****************************************************************************
function XMLRPC_non_fatal_error($array)
// return a non-fatal error to the XML-RPC client
{
    $xml = xmlrpc_encode(array('errors' => $array));

    if (defined('XMLRPC_DEBUG')) {
        echo '<pre>';
    	echo htmlspecialchars($xml);
    	echo '</pre>';
    } else {
        header("Connection: close");
    	header("Content-Type: text/xml");
    	header("Date: " . date("r"));
    	echo $xml;
    } // if
    exit;

} // XMLRPC_non_fatal_error

// *****************************************************************************

?>
