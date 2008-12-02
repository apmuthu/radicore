<?php
// ****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2007 by Radicore Software Limited <http://www.radicore.org>
// ****************************************************************************

// this performs initialisation for a batch process (run from command line)

// ****************************************************************************
function batchInit ($batchfile)
// initialisation for a batch process
{
    echo "<html>\n";
    echo '<p>** started at ' .date('F j, Y, g:i a') ."</p>\n";

    // get fully-qualified name of current file
    $curr_file = str_replace("\\", "/", $batchfile);
    echo '<p>script name  : ' .$curr_file ."</p>\n";
    $curr_dir  = dirname($curr_file);   // extract directory
    chdir($curr_dir);                   // set current working directory to this

    $ini_array = parse_ini_file('batch.ini'); // retrieve variables from file

    $_SERVER['SERVER_NAME'] = $ini_array['server_name'];
    $_SERVER['DOCUMENT_ROOT'] = str_replace("\\", "/", $ini_array['doc_root']);
    $_SERVER["HTTP_ACCEPT_LANGUAGE"] = $ini_array['language'];
    $_SERVER['SCRIPT_FILENAME'] = $curr_file;
    $_SERVER['REMOTE_ADDR'] = 'batch';
    $_SERVER['REQUEST_URI'] = $curr_file;

    // look for INCLUDE_PATH in optional htaccess file
    if (file_exists('.htaccess')) {
    	$fn = '.htaccess';
    } elseif (file_exists('htaccess.txt')) {
        $fn = 'htaccess.txt';
    } // if
    if (!empty($fn)) {
    	$handle = fopen($fn, 'r');
    	while ($string = fgets($handle)) {
    	    $string = trim($string);
    	    if (!empty($string)) {
    	    	list ($php_value, $name, $arg) = explode(' ', $string);
                if ($name == 'include_path') {
                	$arg = trim($arg, '".');
                	$include_path = ini_get('include_path');
                	$include_path .= $arg;
                	ini_set('include_path', $include_path);
                } // if
    	    } // if
        } // while
    	fclose($handle);
    } // if
    if (empty($include_path)) {
    	ini_set('include_path', $ini_array['include_path']);
    } // if

    echo '<p>document root: ' .$_SERVER['DOCUMENT_ROOT'] ."</p>\n";
    echo '<p>server name  : ' .$_SERVER['SERVER_NAME'] ."</p>\n";
    echo '<p>include_path : ' .ini_get('include_path') ."</p>\n";
    echo '<p>language     : ' .$_SERVER["HTTP_ACCEPT_LANGUAGE"] ."</p>\n";

    $PHP_SELF = str_replace($_SERVER['DOCUMENT_ROOT'], "", $curr_file);
    $_SERVER['PHP_SELF'] = $PHP_SELF;

    $_SESSION['role_id']       = 'batch';
    $_SESSION['logon_user_id'] = 'batch';
    $GLOBALS['task_id']        = basename($PHP_SELF);
    $GLOBALS['batch']          = true;
    $GLOBALS['mode']           = 'batch';

    require_once 'include.general.inc';
    require_once 'include.session.inc';

} // batchInit

// ****************************************************************************
function batchEnd ()
//
{
    echo '<p>** finished at ' .date('F j, Y, g:i a') ."</p>\n";
    echo "</html>";

} // batchEnd

// ****************************************************************************
function check_errors ($object)
// check object for errors and terminate if any are found
{
    $errors = $object->getErrors();

	if ($errors) {
	    foreach ($errors as $ix1 => $error1) {
	        if (is_string($error1)) {
	        	$error = $ix1 .': ' .$error1;
	        } elseif (is_array($error1)) {
	            foreach ($error1 as $ix2 => $error2) {
	            	$error = $ix2 .': ' .$error2;
	            	break; // stop after the 1st entry
	            } // foreach
	        } // if
	    	trigger_error($error, E_USER_ERROR);
	    } // foreach
	} // if

} // check_errors

function check_warnings ($object)
// check object for errors and terminate if any are found
{
    $warnings = $object->warnings;

	if ($warnings) {
	    foreach ($warnings as $ix1 => $warning1) {
	        if (is_string($warning1)) {
	        	echo '<p>** ' .$ix1 .': ' .$warning1 .' **</p>' ."\r\n";
	        } elseif (is_array($warning1)) {
	            foreach ($warning1 as $ix2 => $warning2) {
	            	echo '<p>** ' .$ix2 .': ' .$warning2 .' **</p>' ."\r\n";
	            	break; // stop after the 1st entry
	            } // foreach
	        } // if
	    } // foreach
	} // if

} // check_warnings

// ****************************************************************************
?>
