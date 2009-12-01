<?php
// *****************************************************************************
// Copyright 2009 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// this is the XML-RPC server used by RADICORE

// include the standard RADICORE library
require('include.general.inc');

// include the standard XML-RPC library
require('std.xmlrpc.inc');

if (empty($HTTP_RAW_POST_DATA) AND !empty($_POST)) {
    // populate $HTTP_RAW_POST_DATA from $_POST
    $HTTP_RAW_POST_DATA = implode('&', $_POST);
} // if

if (!empty($GLOBALS['project_code'])) {
    // are we using a project subdirectory?
    $dir = 'project/' .$GLOBALS['project_code'] .'/';
} else {
    $dir = '';
} // if

if (empty($HTTP_RAW_POST_DATA) AND isset($_GET['request'])) {
    define('XMLRPC_DEBUG', true);
    // load request details from specified file
    $fn = $dir .'request-' .(int)$_GET['request'] .'.xml';
    if (file_exists($fn)) {
    	$HTTP_RAW_POST_DATA = file_get_contents($fn);
    	if (empty($HTTP_RAW_POST_DATA)) {
    		die("File '$fn' is empty");
    	} // if
    } else {
        die("File '$fn' not found");
    } // if
} // if

if (file_exists('allowed_ip_addr.inc')) {
    $allowed_ip_addr = include('allowed_ip_addr.inc');
} else {
    $allowed_ip_addr = include('allowed_ip_addr.inc.default');
} // if

if (!empty($allowed_ip_addr)) {
	if (!in_array($_SERVER['REMOTE_ADDR'], $allowed_ip_addr)) {
		XMLRPC_fatal_error(27, "Remote Address '" .$_SERVER['REMOTE_ADDR'] ."' is not valid for this service");
	} // if
} // if

if (empty($xmlrpc_methods)) {
    $xmlrpc_methods = require($dir.'xmlrpc_server_api.inc');
} // if

// create the XMLRPC server
$server = xmlrpc_server_create();

// register all the available methods (from xmlrpc_server_api.inc)
foreach ($xmlrpc_methods as $method => $function) {
	$result = xmlrpc_server_register_method($server, $method, $function);
} // foreach

// execute specified method and return response as an XML document
$response = xmlrpc_server_call_method($server, $HTTP_RAW_POST_DATA, $userdata, $server_options);
$output = ob_get_contents();
if (empty($output)) {
    if (isset($_GET['request'])) {
        // display details in web page
        echo '<html><body>';
        echo '<p><b>Result:</b></p>';
        display_array(xmlrpc_decode($response));
        echo '<p><b>Request:</b></p>';
        echo '<pre>' .htmlspecialchars($HTTP_RAW_POST_DATA) .'</pre>';
        echo '<p><b>Response:</b></p>';
        echo '<pre>' .htmlspecialchars($response) .'</pre>';
        echo '</body></html>';
    } else {
        // send result back to the client
        header('Content-Type: text/xml');
        header("Date: " . date("r"));
        echo $response;
    } // if
} // if

?>