<?php
// *****************************************************************************
// Copyright 2009-2010 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// contains additional functions for use with SOAP in PHP 4

$client_options = array();
if (isset($location)) {
	$client_options['location'] = $location;
} // if
if (isset($location)) {
	$client_options['uri'] = $uri;
} // if

$soapaction     = null;
$proxy_host     = null;
$proxy_port     = null;
$proxy_login    = null;
$proxy_password = null;
$timeout          = 30;
$response_timeout = 30;

$input_headers  = array();
$output_headers = array();

$server_options = array('encoding' => 'utf-8');
if (isset($uri)) {
	$server_options['uri'] = $uri;
} // if

// ****************************************************************************
if (!class_exists('SoapClient')) {
	class SoapClient extends nusoap_client {
        function SoapClient($wsdl, $options=null) {
            if (empty($wsdl)) {
                $endpoint = $options['location'];
            	$wsdl     = false;
            } else {
                $endpoint = $wsdl;
                $wsdl     = true;
            } // if
            $proxyhost     =& $options['proxy_host'];
            $proxyport     =& $options['proxy_port'];
            $proxyusername =& $options['proxy_login'];
            $proxypassword =& $options['proxy_password'];

            $timeout       =& $options['timeout'];
            if (empty($timeout)) {
            	$timeout = 30;
            } // if
            $response_timeout =& $options['connection_timeout'];
            if (empty($response_timeout)) {
            	$response_timeout = 30;
            } // if

            parent::nusoap_client($endpoint, $wsdl, $proxyhost, $proxyport, $proxyusername, $proxypassword, $timeout, $response_timeout);
        } // SoapClient

        function __soapCall ($operation, $params=null, $options=null, $input_headers=null, $output_headers=null) {
            if (!empty($options['location'])) {
            	$this->setEndpoint($options['location']);
            } // if
            $namespace  =& $options['uri'];
            if (isset($options['soapaction'])) {
            	$soapAction =& $options['soapaction'];
            } else {
                $soapAction = $namespace .'#' .$operation;
            } // if
            $rpcParams = null;
            if (isset($options['style'])) {
                $style = $options['style'];
            } else {
                $style = 'rpc';
            } // if
            if (isset($options['use'])) {
                $use = $options['use'];
            } else {
                $use='encoded';
            } // if
            $response = parent::call($operation,$params,$namespace,$soapAction,$input_headers,$rpcParams,$style,$use);
            return $response;
        } // __soapCall

    } // class: SoapClient
} // if

// ****************************************************************************
if (!class_exists('SoapFault')) {
    class SoapFault extends nusoap_fault {
        function SoapFault($faultcode,$faultstring,$faultactor=null,$faultdetail=null){
    		parent::nusoap_fault($faultcode,$faultactor,$faultstring,$faultdetail);
    	} // SoapFault
    } // class: SoapFault
} // if

// ****************************************************************************
if (!class_exists('SoapServer')) {
    class SoapServer extends nusoap_server {
        function SoapServer($wsdl, $options=null){
    		parent::nusoap_server($wsdl);
    	} // SoapServer
    	function addFunction ($functions) {
    	    parent::register($functions);
    	} // addFunction
    	function handle ($request) {
    	    parent::service($request);
    	} // addFunction
    } // class: SoapServer
} // if

// ****************************************************************************
if (!function_exists('check_response')) {
    function check_response($object, $response)
    // check the response to see if there some kind of fault
    {
        if ($response === false) {
        	$fault = true;
        } else {
            if (is_array($response)) {
            	if (!empty($response['faultcode'])) {
            		$fault = true;
            	} else {
            	    $fault = false;
            	} // if
            } elseif (is_object($response)) {
                $fault = false;
            } else {
                if (strlen($response) < 1) {
                    if (!empty($object->error_str)) {
                    	return $object->error_str;
                    } else {
                        $fault = false;
                    } // if
                } // if
            } // if
        } // if

        if ($fault === true) {
            if (!empty($response)) {
            	$fault = extract_soap_message($response);
            } // if
        } else {
            // look for an HTTP error
            if (!empty($object->response)) {
            	list($headers, $body) = split_header_from_body($object->response);
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
    function display_soap_debug ($object, $flag=false)
    // display details of request and response
    {
        $output = "<h2>" . date('Y-m-d H:i:s') . "</h2>\n";

        list($header, $body) = split_header_from_body($object->request);
        $output .= "<p>Request Hdr: <br>\n" .nl2br($header) ."</p>\n";
        if (!empty($body)) {
        	if (function_exists('domxml_open_mem')) {
            	$dom = domxml_open_mem($body);
            	$body = $dom->dump_mem(true);
            } elseif (class_exists('DOMdocument')) {
            	$dom = new DOMDocument();
            	$dom->loadXML($body);
            	$dom->formatOutput = true;
            	$body = $dom->saveXML();
            } // if
            if ($flag) {
        		$body = htmlentities($body);
        	} // if
        } // if
        $output .= "<p>Request:\n<pre>" .$body ."</pre></p>\n";

        if (!empty($object->response)) {
            list($header, $body) = split_header_from_body($object->response);
    		$output .= "<p>Response Hdr:\n<br>" .nl2br($header) ."</p>\n";
    		if (!empty($body)) {
    		    if (function_exists('domxml_open_mem')) {
                	$dom = domxml_open_mem($body);
                	$body = $dom->dump_mem(true);
    		    } elseif (class_exists('DOMdocument')) {
                	$dom = new DOMDocument();
                	$dom->loadXML($body);
                	$dom->formatOutput = true;
                	$body = $dom->saveXML();
                } // if
                if ($flag) {
            		$body = htmlentities($body);
            	} // if
    			$output .= "<p>Response:\n<pre>" .$body ."</pre></p>\n";
    		} // if
        } // if

        return $output;

    } // display_soap_debug
} // if

// ****************************************************************************
if (!function_exists('format_soap_error')) {
    function format_soap_error ($object, $response=null)
    // format the components of the SOAP error for display
    {
        $string  = "<p>SOAP fault: <br>\n";
        if (!empty($object->faultcode)) {
        	$string .= "(faultcode  = " .$object->faultcode .")<br>\n";
        } // if
        if (!empty($object->faultstring)) {
        	$string .= "(faultstring= " .$object->faultstring .")<br>\n";
        } else {
            $string .= "(error_str= " .$object->error_str .")<br>\n";
            if (!empty($object->responseData)) {
                $res = $object->responseData;
                $pos = strpos($res, "<?xml");
                if ($pos > 0) {
                    $stuff = substr($res, 0, $pos);
                    $string .= "(data     = " .$stuff .")<br>\n";
                } // if
            } // if
        } // if
        if (!empty($object->detail)) {
            if (is_string($object->detail)) {
            	$string .= "(detail= " .$object->detail .")<br>\n";
            } elseif (is_array($object->detail)) {
                $string .= "(detail= " .extract_soap_message($object->detail) .")<br>\n";
            } // if
        } // if
        if (!empty($object->faultdetail)) {
            $string .= "(faultdetail= " .$object->faultdetail .")<br>\n";
        } // if
        if (!empty($object->faultactor)) {
            $string .= "(faultactor= " .$object->faultactor .")<br>\n";
        } // if
        $string .= "</p>\n";

        if (defined('SOAP_DEBUG')) {
        	 if (!empty($object->request)) {
                list($header, $body) = split_header_from_body($object->request);
        		$string .= "<p>(requestHdr = " .$header .")</p>\n";
        		if (!empty($body)) {
        			$string .= "<p>(request    = " .$body .")</p>\n";
        		} // if
            } // if

            if (!empty($object->response)) {
                list($header, $body) = split_header_from_body($object->response);
        		$string .= "<p>(responseHdr = " .$header .")</p>\n";
        		if (!empty($body)) {
        			$string .= "<p>(response    = " .$body .")</p>\n";
        		} // if
            } // if
        } // if

        return $string;

    } // format_soap_error
} // if

// ****************************************************************************
if (!function_exists('split_header_from_body')) {
    function split_header_from_body ($input)
    // find text beginning with '<?xml' and return that as the body.
    {
        $pos = strpos($input, "<?xml");
    	if ($pos === false) {
    	    $header = $input;
    	    $body   = null;
    	} else {
    	    $header = substr($input, 0, $pos);
    	    $body  = substr($input, $pos);
    	} // if

    	return array($header, $body);

    } // split_header_from_body
} // if

// ****************************************************************************

?>