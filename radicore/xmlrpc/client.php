<?php
// *****************************************************************************
// Copyright 2009 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// this is an example of an XML-RPC client

define('XMLRPC_DEBUG', true);

// Include the library
include('std.xmlrpc.inc');

if (isset($_GET['server'])) {
    // replace server name
	$bits = explode('/', $location);
    $old_server = array_pop($bits);
    $bits[] = $_GET['server'];
	$location = implode('/', $bits);
} // if

// create an instance of the XMLRPC client
$client = new XMLRPC_client($location);
//$client->use_curl = false;    // curl or sockets
//$client->timeout = 30;

?>
<html>
<head>
<title>Example XML-RPC Client</title>
</head>
<body>
<h1>Example XML-RPC Client</h1>
<?php
if (isset($_GET['request'])) {
    $request = (int)$_GET['request'];
} // if

switch ($request) {
	case 2:
		$params['pattern_id'] = 'add1';
	    $method = 'menu.viewPatternId';
		break;

	case 3:
		$params['page_size'] = 10;
        $params['page_no'] = 1;
        $params['order'] = "pattern_id";
        $method = 'menu.getPatternList';
		break;

	case 1;
	default:
	    $params = array();
	    $method = 'menu.getAnswer';
		break;
} // switch

// issue the request and process the response
$success = $client->Request($method, $params);
if (!$success) {
    // show the error
    echo "<p>Error: " .$client->getErrorCode() .' - ' .nl2br($client->getErrorMessage() );
    $client->log_error();
} else {
    $response = $client->response;
    display_array($response);
    echo '<hr>';
    if (defined('XMLRPC_DEBUG')) {
    	$client->debug();
    } // if
} // if
?>
</body>
</html>