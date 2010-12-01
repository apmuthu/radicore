<?php
// generate_wsdl.php

// this uses the NUSOAP library (written for PHP 4) to generate the WSDL file

define('SOAP_DEBUG', true);
define('USE_NUSOAP', true);  // ALWAYS have this turned ON to generate the WSDL

// include the standard RADICORE library
require('include.library.inc');

// Include the standard SOAP library
require('std.soap.inc');
if (file_exists('config.soap.inc')) {
	require('config.soap.inc');
} else {
    require('config.soap.inc.default');
} // if

if (!empty($GLOBALS['project_code'])) {
    // are we using a project subdirectory?
    $dir = 'project/' .$GLOBALS['project_code'] .'/';
} // if

// Include a file that defines all the SOAP operations
$fn = $service.'.api.inc';
if (!empty($dir) AND file_exists($dir.$fn)) {
    // use file found in subdirectory
	$soap_functions = require($dir.$fn);
} else {
    // look in this directory
    $soap_functions = require($fn);
} // if

// create the XMLRPC server
$server = new nusoap_server(null);

// load the details from <service>.api.inc to construct the WSDL file
$server->configureWSDL($service, $uri);
// register all the available methods (from )
foreach ($soap_functions as $function => $array) {
    if ($function == 'complextype') {
    	foreach ($array as $typedata) {
    	    if (preg_match('/^ArrayOf/', $typedata['name'])) {
    	    	$name = substr($typedata['name'], 7);
    	    	if (empty($typedata['phpType'])) {
    	    		$typedata['phpType'] = 'array';
    	    	} // if
    	    	if (empty($typedata['restrictionBase'])) {
    	    		$typedata['restrictionBase'] = 'SOAP-ENC:Array';
    	    	} // if
    	    	if (empty($typedata['attributes'])) {
    	    		$typedata['attributes'] = array('ref' => 'SOAP-ENC:arrayType',
                                                    'wsdl:arrayType' => 'tns:'.$name.'[]');
    	    	} // if
    	    } // if
    	    if (empty($typedata['typeClass'])) {
    	    	$typedata['typeClass'] = 'complexType';
    	    } // if
    	    if (empty($typedata['phpType'])) {
    	    	$typedata['phpType'] = 'struct';
    	    } // if
    	    if (empty($typedata['compositor'])) {
    	    	$typedata['compositor'] = 'all';
    	    } // if
    	    if (empty($typedata['restrictionBase'])) {
    	    	$typedata['restrictionBase'] = '';
    	    } // if
    	    if (empty($typedata['elements'])) {
    	    	$typedata['elements'] = array();
    	    } // if
    	    if (empty($typedata['attributes'])) {
    	    	$typedata['attributes'] = array();
    	    } else {
    	        if (!is_int(key($typedata['attributes']))) {
    	            // array must be indexed, not associative
    	        	$typedata['attributes'] = array($typedata['attributes']);
    	        } // if
    	    } // if
    	    if (empty($typedata['arrayType'])) {
    	    	$typedata['arrayType'] = '';
    	    } // if
    		$server->wsdl->addComplexType($typedata['name'],
                                          $typedata['typeClass'],
                                          $typedata['phpType'],
                                          $typedata['compositor'],
                                          $typedata['restrictionBase'],
                                          $typedata['elements'],
                                          $typedata['attributes'],
                                          $typedata['arrayType']);
    	} // foreach

    } elseif ($function == 'simpletype') {
        foreach ($array as $name => $typedata) {
            //$typedata['name']            = key($typedata);
            $typedata['restrictionBase'] = $typedata['type'];
            $typedata['typeClass']       = null;
            $typedata['phpType']         = null;
            $typedata['enumeration']     = array();
            $server->wsdl->addSimpleType($name,
                                         $typedata['restrictionBase'],
                                         $typedata['typeClass'],
                                         $typedata['phpType'],
                                         $typedata['enumeration']);
        } // foreach

    } elseif ($function == 'element') {
        // nothing defined yet

    } else {
        if (empty($array['namespace'])) {
        	$array['namespace'] = $uri;
        } // if
        if (empty($array['soapaction'])) {
        	$array['soapaction'] = $array['namespace'] .'#' .$function;
        } // if
        if (empty($array['style'])) {
        	$array['style'] = 'rpc';
        } // if
        if (empty($array['use'])) {
        	$array['use'] = 'encoded';
        } // if
	    $result = $server->register($function,
	                                $array['input'],
	                                $array['output'],
	                                $array['namespace'],
	                                $array['soapaction'],
	                                $array['style'],
	                                $array['use'],
	                                $array['documentation']);
    } // if
} // foreach

// execute specified method and return response as an XML document
$server->service(null);
if ($server->fault) {
	// show the error
    if (!empty($server->error_str)) {
    	echo "<p>error_str: " .$server->error_str ."</p>";
    } // if
    if (!empty($server->responseData)) {
		echo "<p>responseData: " .$server->responseData ."</p>";
	} // if
} // if

?>