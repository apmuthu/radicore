<?php
// *****************************************************************************
// Copyright 2009 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
// Version: 1.0.0
// Date: 01-12-2009
// *****************************************************************************

// this file contains functions which use PHP's XMLRPC extension

// obtain config details for this installation
$userdata       = array();
$server_options = array();
require('config.xmlrpc.inc');

// ****************************************************************************
function get_XMLRPC_client ()
// return an object for the XMLRPC client
{
    $object =& singleton::getInstance('XMLRPC_client');

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
    var $use_curl = true;   // yes/no

    var $numrows;
    var $pageno;
    var $lastpage;

    // ****************************************************************************
    function XMLRPC_client ($location=null)
    // constructor for the XMLRPC Client object
    {
        if (!empty($location)) {
        	$result = $this->setLocation($location);
        } // if

        $this->useragent = 'Radicore XMLRPC Client';

        return true;

    } // XMLRPC_client

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

        // convert request into an XML document
        $options = array('encoding' => 'UTF-8');
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

        if (preg_match('/^(http)/i', $response)) {
            // strip http headers from the response
    		$pos = strpos($response, "\r\n\r\n")+4;
    		if ($pos === false) {
    		    $this->responsehdr = $response;
    		    $response          = null;
    		} else {
    		    $this->responsehdr = substr($response, 0, $pos);
    		    $response          = substr($response, $pos);
    		    if (!preg_match('/^(<\?xml)/i', $response)) {
    		        // does not begin with '<?xml', so something must be wrong
    		        $this->errorCode = 'Server: Invalid Response';
        	        $this->errorMsg  = $response;
                    return false;
    		    } // if
    		} // if
        } elseif (!preg_match('/^(<\?xml)/i', $response)) {
            // does not begin with '<?xml', so something must be wrong
            $this->responsehdr = $response;
    		$response          = null;
        } // if

        $this->responseXML = $response;

        if (empty($response)) {
        	$response['faultCode'] = -9998;
        	$response['faultString'] = 'Unexpected error';
        	if (!empty($this->responsehdr)) {
        		$response['faultString'] .= ': ' .$this->responsehdr;
        	} // if
        } else {
            // convert XML document into either a string or an array
    		$response = xmlrpc_decode($response);
    		if (is_array($response)) {
    			$response = $this->convert_types($response);
    		} elseif (empty($response)) {
    			$this->errorCode = 'Server: Invalid Response';
    	        $this->errorMsg  = 'Response is empty';
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
			foreach ($data as $fieldname => $fieldvalue) {
                if (is_object($fieldvalue)) {
                    if ($fieldvalue->xmlrpc_type == 'datetime') {
                    	$data[$fieldname] = date('Y-m-d H:i:s', $fieldvalue->timestamp);
                    } elseif ($fieldvalue->xmlrpc_type == 'base64') {
                        $data[$fieldname] = base64_decode($fieldvalue->base64);
                    } // if
                } // if
			} // foreach
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
        if (!empty($this->requestHdr)) {
        	echo "<p>Request Hdr: <br>" .nl2br($this->requestHdr) ."</p>";
        } // if
        if (!empty($this->request)) {
        	echo "<p>Request: <pre>" .htmlspecialchars($this->request) ."</pre></p>";
        } // if
        if (!empty($this->responsehdr)) {
            echo "<p>Response Hdr: <br>" .nl2br($this->responsehdr) ."</p>";
        } // if
        if (!empty($this->responseXML)) {
            echo "<p>Response: <pre>" .htmlspecialchars($this->responseXML) ."</pre></p>";
        } // if

    } // debug

    // ****************************************************************************
    function log_error ()
    // send a copy of these error details to a log file (or email)
    {
        $mailstring = '';

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
        if (!empty($this->responsehdr)) {
            $mailstring .= "Response Hdr:\n" .$this->responsehdr ."\n";
        } // if
        if (!empty($this->responseXML)) {
            $mailstring .= "Response:\n" .$this->responseXML ."\n";
        } // if

        $headers = "From: XML-RPC Client\r\n";
        @error_log($mailstring, 1, $_SERVER['SERVER_ADMIN'], $headers);

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

    } // setError

    // ****************************************************************************
    function _send($site, $location, $port=null, $request=null, $user_agent=null, $timeout=30)
    // send the request to the server and receive a response.
    {
        //$this->use_curl = false;
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

// ****************************************************************************
function display_array ($input, $prefix=null)
// an alternative to print_r()
{
    if (is_string($input)) {
    	echo $input;
    } elseif (is_bool($input)) {
        if ($input) {
        	echo 'True';
        } else {
            echo 'False';
        } // if
    } elseif (is_array($input)) {
        foreach ($input as $key => $value) {
        	if (is_array($value)) {
        		display_array($value, $prefix.'['.$key.']');
        		echo '<br>';
        	} else {
        	    if (empty($prefix)) {
        	    	echo               $key .' = ' .$value .'<br>';
        	    } else {
        	        echo $prefix .' ' .$key .' = ' .$value .'<br>';
        	    } // if
        	} // if
        } // foreach
    } else {
        echo $input;
    } // if
    return;
} // display_array

?>