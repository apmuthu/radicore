<?php
// *****************************************************************************
// Copyright 2003-2004 by A J Marston <http://www.tonymarston.net>
// *****************************************************************************

// *****************************************************************************
// This is the main logon screen.
// The user must enter a valid username and password before being allowed
// to access the remainder of the system.
// *****************************************************************************

//DebugBreak();
$table_id = 'logon';                // table name
$title    = 'System Logon';         // form title
$xsl_file = 'logon.xsl';            // xsl file for transformation
$screen   = 'logon.screen.inc';     // file identifying screen structure

require 'include.general.inc';
require "classes/$table_id.class.inc";

// get details from any previous session
if (isset($session_name)) {
    // use existing session name
} else {
    // assign new session name
    $session_name = getNewSession('menu');
} // if
session_name($session_name);
session_start();

if (isset($_SESSION['message'])) {
    $message = $_SESSION['message'];
} // if
if (isset($_SESSION['logon_retries'])) {
    $logon_retries = $_SESSION['logon_retries'];
} // if
if (isset($_SESSION['user_id'])) {
    $_POST['user_id']       = $_SESSION['user_id'];
    $_POST['user_password'] = $_SESSION['user_password'];
} // if
if (isset($_SESSION['XSLT_client_side'])) {
	$XSLT_client_side = $_SESSION['XSLT_client_side'];
} // if
if (isset($_SESSION['logon_user_id'])) {
    $dbobject = new $table_id;
    // log the current user off
    $errors = $dbobject->user_logoff($_SESSION['logon_user_id']);
	unset($dbobject);
} // if
if (empty($_SESSION)) {
    // if $_SESSION is empty then $_POST must be empty as well
    $_POST = null;
} // if

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    // get default language from control table
    require_once 'classes/mnu_control.class.inc';
    $mnu_control = new mnu_control;
    $default_language    = $mnu_control->getControlData('default_language');
} else {
    $default_language    = $_SESSION['default_language'];
} // if

// unset any previous session data
session_unset();

// identify mode for xsl file
$mode    = 'logon';
$task_id = 'logon';

// initialise a new session
initSession();

$_SESSION['default_language'] = $default_language;

// define action buttons
$act_buttons['submit'] = getLanguageText('login');

if (isset($_POST['quit']) or (isset($_POST['quit_x']))) {
    // cancel this screen, return to previous screen
    scriptPrevious(null, 'quit');
} // if

if (isset($logon_retries)) {
    $_SESSION['logon_retries'] = $logon_retries;
} // if

// create a class instance for the main database table
$dbobject = new $table_id;

// look for entered data
if (!empty($_POST)) {
    // attempt to log on using this data
    $result = $dbobject->user_logon($_POST);
	if (!empty($result)) {
		// errors are keyed by object name
	    $errors[$dbobject->getClassName()] = $result;
	} // if
    if (!$errors) {
        $dbobject->commit();
        // logon is OK - go to next screen
        $fieldarray = $dbobject->getFieldArray();
        $_SESSION['start_task_id'] = $fieldarray[0]['start_task_id'];
        $query_string = "selection={$fieldarray[0]['start_task_id']}";
        scriptNext('menu');
    } // if
} else {
    // get initial data for a new record
    $fieldarray = $dbobject->getInitialData($where);
    $result = $dbobject->getErrors();
	if (!empty($result)) {
		// errors are keyed by object name
	    $errors[$dbobject->getClassName()] = $result;
	} // if
} // if

// initialise $page_stack
$_SESSION['page_stack'] = array();

$xml_objects[]['root'] = &$dbobject;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);
exit;

?>
