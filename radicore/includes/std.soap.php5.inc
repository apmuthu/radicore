<?php
// *****************************************************************************
// Copyright 2009-2010 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// contains additional functions for use with SOAP in PHP 5

$client_options = array('exceptions' => false,
                        'trace' => true,
                        'style' => SOAP_RPC,
                        'use' => SOAP_ENCODED,
                        'encoding' => 'UTF-8',
                        'cache_wsdl' => WSDL_CACHE_NONE,
//                        'proxy_host' => $proxy_host,
//                        'proxy_port' => $proxy_port,
//                        'proxy_login' => $proxy_login,
//                        'proxy_password' => $proxy_password,
//                        'local_cert' => null,
//                        'passphrase' => null,
//                        'compression' => false,
//                        'classmap' => null,
//                        'typemap' => null,
//                        'user_agent' => null,
//                        'stream_context' => null,
                        'features' => SOAP_SINGLE_ELEMENT_ARRAYS);
if (isset($location)) {
	$client_options['location'] = $location;
} // if
if (isset($location)) {
	$client_options['uri'] = $uri;
} // if

$input_headers  = array();
$output_headers = array();

$server_options = array('encoding' => 'utf-8',
                        'cache_wsdl' => WSDL_CACHE_NONE);
if (isset($uri)) {
	$server_options['uri'] = $uri;
} // if

// ****************************************************************************
if (!function_exists('check_response')) {
    function check_response($object, $response)
    // check the response to see if there some kind of fault
    {
        if (is_soap_fault($object) OR isset($object->__soap_fault)
        OR (is_array($response) AND !empty($response['faultstring']))) {
            $fault = true;
        } else {
            $fault = false;
        } // if

        if ($fault === true) {
            if (!empty($response)) {
                $fault = extract_soap_message($response);
            } // if
        } else {
            // look for an HTTP error
            if ($headers = $object->__getLastResponseHeaders()) {
                // look for string following 'HTTP/1.1 '
                if (preg_match('#(?<=HTTP/[0-9]\.[0-9] ).*#i', $headers, $regs)) {
                    $response = trim($regs[0]);
                	if ($response != '200 OK') {
                	    // extract whole of first line
                	    preg_match('#(.)*#', $headers, $regs);
                	 	$fault = $regs[0];
                	} // if
                } // if
            } // if
        } // if

        return $fault;

    } // check_response
} // if

// ****************************************************************************
if (!function_exists('display_soap_debug')) {
    function display_soap_debug ($object, $echo=false)
    // output details of request and response.
    // if $echo is TRUE then output will be displayed in the browser window.
    {
        $output = null;
        //$output = "<h2>" . date('Y-m-d H:i:s') . "</h2>\n";

        $header = $object->__getLastRequestHeaders();
        $output .= "<p>Request Hdr:<br>\n" .nl2br($header) ."</p>\n";
        $body = $object->__getLastRequest();
        if (!empty($body)) {
        	if (class_exists('DOMdocument')) {
            	$dom = new DOMDocument();
            	$dom->loadXML($body);
            	$dom->formatOutput = true;
            	$body = $dom->saveXML();
            } // if
            if ($echo) {
        		$body = htmlentities($body);
        	} // if
        	$output .= "<p>Request:\n<pre>" .$body ."</pre></p>\n";
        } // if

        $header = $object->__getLastResponseHeaders();
        if (!empty($header)) {
        	$output .= "<p>Response Hdr:<br>\n" .nl2br($header) ."</p>\n";
        } // if
        $body = $object->__getLastResponse();
        if (!empty($body)) {
            if (preg_match('/^<\?xml/i', $body)) {
            	if (class_exists('DOMdocument')) {
                	$dom = new DOMDocument();
                	$dom->loadXML($body);
                	$dom->formatOutput = true;
                	$body = $dom->saveXML();
                } // if
                if ($echo) {
            		$body = htmlentities($body);
            	} // if
            } // if
            $output .= "<p>Response:\n<pre>" .$body ."</pre></p>\n";
        } // if

        if ($echo === false) {
            // remove all HTML tags
        	$search = array('<br>', '<br />', '<p>', '</p>', '<pre>', '</pre>', '<h2>', '</h2>');
            $output = str_replace($search, array(''), $output);
        } // if

        return $output;

    } // display_soap_debug
} // if

// ****************************************************************************
if (!function_exists('format_soap_error')) {
    function format_soap_error ($object, $response)
    // put the details of the error into a string to be displayed.
    {
        $string  = "<p>SOAP fault: <br>\n";
        $string .= "(faultcode  = " .$response['faultcode'] .")<br>\n";
        $string .= "(faultstring= " .$response['faultstring'] .")<br>\n";
        if (!empty($response['faultactor'])) {
            $string .= "(faultactor = " .$response['faultactor'] .")<br>\n";
        } // if
        if (!empty($response['detail'])) {
            if (is_string($response['detail'])) {
            	$string .= "(detail= " .$response['detail'] .")<br>\n";
            } elseif (is_array($object['detail'])) {
                $string .= "(detail= " .extract_soap_message($response['detail']) .")<br>\n";
            } // if
        } // if
        $res = $object->__getLastResponse();
        if (!empty($res)) {
            $pos = strpos($res, "<?xml");
            if ($pos > 0) {
            	$stuff = substr($res, 0, $pos);
            	$string .= "(data     = " .substr($res, 0, $pos) .")<br>\n";
            } // if
        } // if
        $string .= "</p>\n";

        if (defined('SOAP_DEBUG')) {
            $hdr = $object->__getLastRequestHeaders();
            if (!empty($hdr)) {
                $string .= "<p>(requestHdr = " .$hdr .")</p>\n";
            } // if
            $body = $object->__getLastRequest();
            if (!empty($body)) {
            	$string .= "<p>(request    = " .$body .")</p>\n";
            } // if

            $hdr = $object->__getLastResponseHeaders();
            if (!empty($hdr)) {
                $string .= "<p>(responseHdr= " .$hdr .")</p>\n";
            } // if
            $body = $object->__getLastResponse();
            if (!empty($body)) {
                $string .= "<p>(response   = " .$body .")</p>\n";
            } // if
        } // if

        return $string;

    } // format_soap_error
} // if

// ****************************************************************************

?>