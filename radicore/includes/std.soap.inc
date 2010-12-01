<?php
// *****************************************************************************
// Copyright 2009-2010 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// this file contains functions which use PHP's SOAP extension

// are we using PHP 5, or something earlier?
if (defined('USE_NUSOAP') OR version_compare(phpversion(), '5.0.0', '<')) {
	// use NUSOAP library
    require_once('nusoap.php');
    require('std.soap.php4.inc');
} else {
    // use PHP's SOAP extension
    require('std.soap.php5.inc');
} // if

require_once('include.library.inc');

if (!isset($wsdl)) {
	$wsdl = null;
} // if
if (!isset($input_headers)) {
	$input_headers = null;
} // if
if (!isset($output_headers)) {
	$output_headers = null;
} // if

// ****************************************************************************
if (!function_exists('convert_types')) {
	function convert_types ($input)
    // examine all values in $input (which should be an array or an object)
    // to see if they need to be converted into displayable values.
    // $output is an asociative array.
    {
    	foreach ($input as $fieldname => $fieldvalue) {
            if (is_array($fieldvalue)) {
                $output[$fieldname] = $fieldvalue['scalar'];
            } elseif (is_object($fieldvalue)) {
                if ($fieldvalue->xmlrpc_type == 'datetime') {
                    $output[$fieldname] = $fieldvalue->scalar;
                } elseif ($fieldvalue->xmlrpc_type == 'base64') {
                    $output[$fieldname] = base64_decode($fieldvalue->base64);
                } // if
            } else {
                $output[$fieldname] = $fieldvalue;
            } // if
    	} // foreach

    	return $output;

    } // convert_types
} // if

// ****************************************************************************
if (!function_exists('XMLRPC_errorhandler')) {
    function XMLRPC_errorhandler($faultCode=null, $faultString=null, $actor=null, $detail=null)
    // send details of this error back to the SOAP client.
    // (see 'errorHandler' in error.inc)
    {
        if (empty($faultCode)) {
        	$faultCode   = -9999;
        } // if
        if (empty($faultString)) {
        	$faultString = 'SOAP Server - unexpected error';
        } // if

        $xml = <<<EOD
<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
 <SOAP-ENV:Body>
  <SOAP-ENV:Fault>
   <faultcode>{$faultCode}</faultcode>
   <faultstring>{$faultString}</faultstring>
   <faultactor>{$actor}</faultactor>
   <detail>{$detail}</detail>
  </SOAP-ENV:Fault>
 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
EOD;

        header("Connection: close");
        header("Content-Type: text/xml");
        header("Date: " . date("r"));

        echo $xml;

    } // XMLRPC_errorhandler
} // if

// ****************************************************************************
if (!function_exists('SOAP_error')) {
    function SOAP_error($faultCode, $faultString, $actor=null, $detail=null)
    // send error details back to the client.
    {
        XMLRPC_errorhandler($faultCode, $faultString, $actor, $detail);
        exit;

    } // SOAP_error
} // if

// ****************************************************************************
if (!function_exists('iso8601_to_timestamp')) {
    if (!function_exists('iso8601_to_timestamp')) {
    	function iso8601_to_timestamp($datestr){
        	$eregStr =  '/'.
                    	'([0-9]{4})-'.	// centuries & years CCYY-
                    	'([0-9]{2})-'.	// months MM-
                    	'([0-9]{2})'.	// days DD
                    	'T'.			// separator T
                    	'([0-9]{2}):'.	// hours hh:
                    	'([0-9]{2}):'.	// minutes mm:
                    	'([0-9]{2})(\.[0-9]+)?'. // seconds ss.ss...
                    	'(Z|[+\-][0-9]{2}:?[0-9]{2})?'. // Z to indicate UTC, -/+HH:MM:SS.SS... for local tz's
                    	'/';
        	if (preg_match($eregStr, $datestr, $regs)){
        		// not utc
        		if ($regs[8] != 'Z'){
        			$op = substr($regs[8],0,1);
        			$h = substr($regs[8],1,2);
        			$m = substr($regs[8],strlen($regs[8])-2,2);
        			if ($op == '-'){
        				$regs[4] = $regs[4] + $h;
        				$regs[5] = $regs[5] + $m;
        			} elseif ($op == '+'){
        				$regs[4] = $regs[4] - $h;
        				$regs[5] = $regs[5] - $m;
        			} // if
        		} // if
        		return gmmktime($regs[4], $regs[5], $regs[6], $regs[2], $regs[3], $regs[1]);
        //		return strtotime("$regs[1]-$regs[2]-$regs[3] $regs[4]:$regs[5]:$regs[6]Z");
        	} else {
        		return false;
        	} // if

        } // iso8601_to_timestamp
    } // if
} // if

// ****************************************************************************
if (!function_exists('extract_soap_message')) {
    function extract_soap_message ($input, $prefix='')
    // look for an element named 'message' in the input, then output the contents
    // (NOTE: it may be several levels deep)
    {
        $output = '';

        if (is_string($input)) {
            $output .= $input;
        } elseif (is_array($input) OR is_object($input)) {
            foreach ($input as $key => $value) {
                if (is_array($value) OR is_object($value)) {
                    $output .= extract_soap_message($value, $prefix.'['.$key.']');
                } else {
                    if (empty($prefix)) {
                        $output .=               $key .' = ' .$value ."\n";
                    } else {
                        $output .= $prefix .' ' .$key .' = ' .$value ."\n";
                    } // if
                } // if
            } // foreach
        } else {
            $output .= $input;
        } // if

        return $output;

    } // extract_soap_message
} // if

// ****************************************************************************
if (!function_exists('unpack_rdc_errors')) {
    if (!function_exists('unpack_rdc_errors')) {
        function unpack_rdc_errors ($response)
        // convert array('key' => 'fieldname', 'value' => 'fieldvalue')
        // to array('fieldname' => 'fieldvalue').
        {
            $errors = array();

            foreach ($response['rdc_errors']['item'] as $key => $value) {
                if (is_array($value)) {
                    // multiple entries indexed by sequence number
                    $errors[$value[key($value)]] = $value['value'];
                } else {
                    // 'fieldname' and 'fieldvalue' are in separate entries
                    if ($key == 'key') {
                    	$fieldname = $value;
                    } elseif ($key == 'value') {
                    	$errors[$fieldname] = $value;
                    } // if
                } // if
            } // foreach

            unset($response['rdc_errors']);
            $response['errors'] = $errors;

            return $response;

        } // unpack_rdc_errors
    } // if
} // if

// ****************************************************************************

?>