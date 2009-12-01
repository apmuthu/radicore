<?php
// *****************************************************************************
// Copyright 2009 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// this is the XML-RPC server used by RADICORE

if (isset($_GET['request'])) {
    // load request details from specified file
    $request = (int)$_GET['request'];
    $HTTP_RAW_POST_DATA = file_get_contents("test-request-$request.xml");
} // if

$xmlrpc_methods = require('test.xmlrpc_server_api.inc');

// transfer control to standard server
require('server.php');

?>