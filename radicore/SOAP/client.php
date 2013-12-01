<?php
// client.php

// SOAP client - for PHP 5

define('SOAP_DEBUG', true);
//define('USE_NUSOAP', true);

// Include the standard SOAP library
require('std.soap.inc');
if (file_exists('config.soap.inc')) {
	require('config.soap.inc');
} else {
    require('config.soap.inc.default');
} // if

if (!empty($service)) {
    $wsdl = $service .'.wsdl';
} else {
    $wsdl = null;
} // if

if (isset($_GET['server'])) {
    // replace server name (usually to the test server)
	$bits = explode('/', $location);
    $old_server = array_pop($bits);
    $bits[] = $_GET['server'];
	$client_options['location'] = implode('/', $bits);
	$client_options['uri']      =& $uri;
} // if

if (empty($wsdl)) {
    $client_options['uri'] =& $uri;
} // if

// create an instance of the SOAP client
if (version_compare(phpversion(), '5.0.0', '<') OR defined('USE_NUSOAP')) {
    if (empty($wsdl)) {
        $endpoint = $client_options['location'];
    	$wsdl     = false;
    } else {
        $endpoint = $wsdl;
        $wsdl     = true;
    } // if
    $client = new nusoap_client($endpoint, $wsdl);
    if (!empty($client_options['location'])) {
    	$client->setEndpoint($client_options['location']);
    } // if
} else {
    $client = new SoapClient($wsdl, $client_options);
} // if

?>
<html>
<head>
<title>Radicore SOAP client</title>
</head>

<body>
<h1>Radicore SOAP client</h1>
<?php
if (isset($_GET['request'])) {
    $request = (int)$_GET['request'];
} else {
    $request = null;
} // if

switch ($request) {
	case 2:
		$operation = 'menu_viewPatternId';
		$params['pattern_id'] = 'add1';
	    break;

	case 3:
		$operation = 'menu_getPatternList';
		$params['limit']     = 10;
		$params['page_no']   = 1;
        $params['order']     = "pattern_id";
        break;

	case 1;
	default:
	    $operation = 'menu_getAnswer';
	    $params = null;
	    break;
} // switch

if (version_compare(phpversion(), '5.0.0', '<') OR defined('USE_NUSOAP')) {
	$response = $client->call($operation, array('params' => $params));
} else {
    $response = $client->$operation($params);
} // if

$response = object2array($response);

if ($fault = check_response($client, $response)) {
    $echo_or_email = 'echo';
    if ($echo_or_email == 'echo') {
    	$string = display_soap_debug($client, true);
        echo $fault ,"\n" .$string;
    } else {
        $string = display_soap_debug($client);
        $headers = "From: {$_SERVER['HTTP_HOST']}\r\n";
        $search = array('<br>', '<br />', '<p>', '</p>', '<pre>', '</pre>', '<h2>', '</h2>');
        $string = str_replace($search, array(''), $string);
        error_log("$fault\n$string", 1, $_SERVER['SERVER_ADMIN'], $headers);
    } // if
} else {
    echo "Operation: $operation<br>\n";
    echo "Response:<br>\n";
    if (is_array($response)) {
    	if (array_key_exists('rdc_errors', $response)) {
        	$response = unpack_rdc_errors($response);
        } // if
    } // if
    $string = format_array($response);
    echo $string ."<br>\n";
    if (defined('SOAP_DEBUG')) {
    	$string = display_soap_debug($client, true);
        echo $fault ,"\n" .$string;
    } // if
} // if

?>
</body>
</html>