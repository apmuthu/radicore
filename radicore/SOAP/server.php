<?php
// *****************************************************************************
// Copyright 2010 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// this is the SOAP server used by RADICORE

// include the standard RADICORE library
require_once('include.general.inc');

// include the standard SOAP library
require('std.soap.inc');
if (file_exists('config.soap.inc')) {
	require('config.soap.inc');
} else {
    require('config.soap.inc.default');
} // if

if (empty($HTTP_RAW_POST_DATA) AND !empty($_POST)) {
    // populate $HTTP_RAW_POST_DATA from $_POST
    $HTTP_RAW_POST_DATA = implode('&', $_POST);
} // if

// extract operation name and namespace from XML input
$xml = new XMLReader();
$xml->xml($HTTP_RAW_POST_DATA);
$prev_element = '';
while ($xml->read()) {
    if ($xml->nodeType == XMLREADER::ELEMENT) {
        if ($prev_element == 'Body') {
        	$operation = $xml->localName;
        	$namespace = $xml->namespaceURI;
        	if (preg_match("/(?<=urn:)\w+(\.[0-9]*)*/", $namespace, $regs)) {
                $service = $regs[0];
            } // if
        	break;
        } else {
            $prev_element = $xml->localName;
        } // if
    	//echo $xml->nodeType .':' .$xml->localName .':' .$xml->value .':' .$xml->prefix.':' .$xml->namespaceURI ."\n";
    } // if
} // while

if (empty($service)) {
	$service = 'unknown';
} // if

$wsdl = $service .'.wsdl';

if (!empty($GLOBALS['project_code'])) {
    $dir = 'project/' .$GLOBALS['project_code'] .'/';
    if (file_exists($dir.$wsdl)) {
        // use wsdl file found in project subdirectory
    	$wsdl = $dir.$wsdl;
    } else {
        $dir = null;
    } // if
} else {
    // assume wsdl file is in current directory
} // if

if (!empty($wsdl)) {
    if (!file_exists($wsdl)) {
    	SOAP_error('Server', "WSDL file for service '$service' does not exist");
    	exit;
    } // if
} else {
    if (!empty($uri)) {
    	$server_options['uri'] = $uri;
    } else {
        $server_options['uri'] = $namespace;
    } // if
} // if

if (empty($soap_methods)) {
    $soap_methods = require($dir.$service.'.api.inc');
} // if

if (file_exists('allowed_ip_addr.inc')) {
    $allowed_ip_addr = include('allowed_ip_addr.inc');
} else {
    $allowed_ip_addr = include('allowed_ip_addr.inc.default');
} // if

if (!empty($allowed_ip_addr)) {
	if (!in_array($_SERVER['REMOTE_ADDR'], $allowed_ip_addr)) {
		SOAP_error(27, "Remote Address '" .$_SERVER['REMOTE_ADDR'] ."' is not valid for this service");
	} // if
} // if

// create the SOAP server
$server = new SoapServer($wsdl, $server_options);

// register all the available functions defined in the api file
foreach ($soap_methods as $function => $array) {
    if (preg_match('/^(simpleType|complexType|element)$/i', $function)) {
        // do nothing
    } else {
        $result = $server->addFunction($function);
    } // if
} // foreach

ob_start();

// execute specified method and return response as an XML document
$server->handle($HTTP_RAW_POST_DATA);

if (defined('USE_NUSOAP') OR version_compare(phpversion(), '5.0.0', '<')) {
    if ($server->fault) {
    	// show the error
        if (!empty($server->error_str)) {
        	echo "<p>error_str: " .$server->error_str ."</p>";
        	if (!empty($server->responseData)) {
        		echo "<p>responseData: " .$server->responseData ."</p>";
        	} // if
        } // if
    } // if
} // if

$output = ob_get_clean();
echo $output;

?>