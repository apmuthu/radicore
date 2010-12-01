<?php
// *****************************************************************************
// Copyright 2010 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// this is the SOAP server used by RADICORE for testing purposes

if (isset($_GET['request'])) {
    // load request details from specified file
    $request = (int)$_GET['request'];
    $fn = "test-request-$request.xml";
    if (!file_exists($fn)) {
    	echo "File $fn does not exist";
    	exit;
    } // if
    // load input data from disk file
    $HTTP_RAW_POST_DATA = file_get_contents($fn);
    unset($fn);
} // if

// load file which executes the SOAP methods
$soap_methods = require('radicore_v1.api.inc');

// transfer control to standard server
require('server.php');

?>