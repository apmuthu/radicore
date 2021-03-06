<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// *****************************************************************************
// This is the main logon screen.
// The user must enter a valid username and password before being allowed
// to access the remainder of the system.
// *****************************************************************************

error_reporting(-1);
ini_set('display_errors', true);

$table_id = 'logon';               // table name
$title    = 'System Logon';        // form title
$screen   = 'logon.screen.inc';    // file identifying screen structure

if (!isset($radius_auth_off) AND !isset($external_auth_off)) {
	$external_auth_off=false;      // do not turn External Authentication off
} // if

// identify mode for xsl file
$mode    = 'logon';
$task_id = 'logon';

require 'include.general.inc';
require "classes/$table_id.class.inc";

// get details from any previous session
if (isset($session_name) AND preg_match('/^menu/i', $session_name)) {
    // use existing session name
} else {
    // assign new session name
    $session_name = getNewSession('menu');
} // if
session_name($session_name);
if (isset($_GET['session_id'])) {
    session_id($_GET['session_id']);        // supplied in the URL
} elseif (isset($_COOKIE[$session_name])) {
	session_id($_COOKIE[$session_name]);    // supplied in a cookie
} // if
session_start();

$PHP_SELF = getSelf();
$save_session_data = array();

if (isset($_SESSION['pages'][$PHP_SELF])) {
    $logon_data = $_SESSION['pages'][$PHP_SELF];
} // if
if (isset($_SESSION['messages'])) {
    $messages_bf = (array)$_SESSION['messages'];
} // if
if (isset($_SESSION['SSO'])) {
    $SSO = $_SESSION['SSO'];  // Single Sign On requested from this script
} // if
if (isset($_SESSION['errors'])) {
    $errors_bf = (array)$_SESSION['errors'];
} // if
if (isset($_SESSION['logon_retries'])) {
    $save_session_data['logon_retries'] = $_SESSION['logon_retries'];
} // if
if (isset($_SESSION['user_id'])) {
    $_POST['user_id']       = $_SESSION['user_id'];
    $_POST['user_password'] = $_SESSION['user_password'];
} // if
if ((isset($_GET['user_id']) OR isset($_GET['email_addr'])) AND isset($_GET['user_password'])) {
    // allow logon credentials to be supplied in the URL
    if (isset($_GET['user_id'])) {
    	$_POST['user_id']    = $_GET['user_id'];
    	$_SESSION['user_id'] = $_GET['user_id'];
    } // if
    if (isset($_GET['email_addr'])) {
    	$_POST['email_addr']    = $_GET['email_addr'];
    	$_SESSION['email_addr'] = $_GET['email_addr'];
    } // if
    $_POST['user_password'] = $_GET['user_password'];
    $_SESSION['logon_retries'] = 0;
} // if
if (isset($_SESSION['XSLT_client_side'])) {
	$GLOBALS['XSLT_client_side'] = $_SESSION['XSLT_client_side'];
} // if
if (isset($_SESSION['css_file'])) {
	$save_session_data['css_file'] = $_SESSION['css_file'];
} elseif (isset($_COOKIE['theme'])) {
    $save_session_data['css_file'] = $_COOKIE['theme'];
} // if
if (isset($_SESSION['cookie_data'])) {
	$save_session_data['cookie_data'] = $_SESSION['cookie_data'];
} // if
if (isset($_SESSION['cookie_time'])) {
	$save_session_data['cookie_time'] = $_SESSION['cookie_time'];
} // if
if (isset($_SESSION['restore_cookie_data'])) {
	$save_session_data['restore_cookie_data'] = $_SESSION['restore_cookie_data'];
} // if
if (isset($_SESSION['logon_user_id'])) {
    $dbobject = new $table_id;
    // log the current user off
    $errors = $dbobject->user_logoff($_SESSION['logon_user_id']);
	unset($dbobject);
} // if
if (count($_SESSION) <= 1) {
    // if $_SESSION is empty then $_POST must be empty as well
    $_POST = array();
} // if
if (!empty($_SESSION['QUERY_STRING'] )) {
    $QUERY_STRING = $_SESSION['QUERY_STRING'];
} // if

if (!empty($GLOBALS['https_server']) AND empty($_SERVER['HTTPS'])) {
    // script will be restarted using HTTPS protocol, so do not clear session data
} else{
    // unset any previous session data
    session_unset();
} // if

if (isset($messages_bf)) {
    $_SESSION['messages'] = $messages_bf;   // put these messages back
} // if
if (isset($SSO)) {
    $_SESSION['SSO'] = $SSO;                // put SSO details back
} // if

if (!empty($_SERVER['QUERY_STRING'])) {
    $_SERVER['QUERY_STRING'] = str_replace('&amp;', '&', $_SERVER['QUERY_STRING']);
    parse_str($_SERVER['QUERY_STRING'], $QUERY_STRING);
    unset($QUERY_STRING['session_name']);
    unset($QUERY_STRING['session_id']);
    if (!empty($QUERY_STRING)) {
        $_SESSION['QUERY_STRING'] = http_build_query($QUERY_STRING);
    } else {
        unset($_SESSION['QUERY_STRING']);
    } // if
} elseif (!empty($QUERY_STRING) AND is_string($QUERY_STRING)) {
    $_SESSION['QUERY_STRING'] = $QUERY_STRING;
} // if

// initialise a new session (but add saved data)
initSession($save_session_data);

$_SESSION['pages'][$PHP_SELF]['pattern_id'] = 'logon';

// define action buttons
//$act_buttons['submitBtn'] = 'login';
$act_buttons['submitLogin'] = 'login';

if (isset($_POST['quit']) or (isset($_POST['quit_x']))) {
    // cancel this screen, return to previous screen
    scriptPrevious(null, 'quit');
} // if

if (isset($logon_data)) {
    if (isset($logon_data['logon']['errors'])) {
    	$errors = (array)$logon_data['logon']['errors'];
    } // if
    if (isset($logon_data['logon']['messages'])) {
    	$messages = (array)$logon_data['logon']['messages'];
    } // if
} // if

// create a class instance for the main database table
$dbobject = new $table_id;

// look for entered data
if (!empty($_POST)) {
    // attempt to log on using this data
    $dbobject->startTransaction();
    $_SESSION['logon_user_id'] = null;
    $result = $dbobject->user_logon($_POST, $external_auth_off);
	if (!empty($result)) {
		// errors are keyed by object name
	    $errors[$dbobject->getClassName()] = $result;
	} // if
    if ($errors) {
        //$dbobject->rollback();
        $dbobject->commit();
    } else {
        // logon is OK - go to next screen
        $dbobject->commit();
        $res = session_regenerate_id(true); // drop the old session_id and create a new one
        $fieldarray = $dbobject->getFieldArray();
        $messages   = $dbobject->getMessages();
        if (isset($GLOBALS['use_https']) AND $GLOBALS['use_https'] === true) {
            // turn on HTTP Strict Transport Security (HSTS)
            header('Strict-Transport-Security: max-age=31536000; includeSubDomains');
        } // if
        $_SESSION['motd'] = true; // go to the MOTD screen once and once only in this session
        $task_array['query_string'] = "selection={$fieldarray[0]['start_task_id']}";
        scriptNext('menu', null, null, $task_array);
    } // if
} else {
    // get initial data for a new record
    $fieldarray = $dbobject->getInitialData($where);
    $result = $dbobject->getErrors();
	if (!empty($result)) {
		// errors are keyed by object name
	    $errors[$dbobject->getClassName()] = $result;
	} // if
	if (isset($messages_bf)) {
    	$messages = $messages_bf;
    } // if
} // if

if (isset($errors_bf)) {
    $errors = array_merge($errors, $errors_bf);
} // if

// initialise $page_stack
$_SESSION['page_stack'] = array();

$xml_objects[]['root'] = &$dbobject;

if (isset($GLOBALS['use_https']) AND $GLOBALS['use_https'] === true) {
    // turn on HTTP Strict Transport Security (HSTS)
    header('Strict-Transport-Security: max-age=31536000; includeSubDomains');
} // if

// build XML document and perform XSL transformation
$view = new radicore_view($screen_structure);
$html = $view->buildXML($xml_objects, $errors, $messages);
echo $html;
exit;

?>
