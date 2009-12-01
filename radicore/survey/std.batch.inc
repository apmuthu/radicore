<?php
// ****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2009 by Radicore Software Limited <http://www.radicore.org>
// ****************************************************************************

// this performs initialisation for a batch process (run from command line)

// ****************************************************************************
function batchInit ($batchfile)
// initialisation for a batch process
{
    global $stdout, $stdouth;

    $result = ini_set('max_execution_time', 0);  // no time limit

    // get fully-qualified name of current file
    $curr_file = str_replace("\\", "/", $batchfile);
    $curr_dir  = dirname($curr_file);   // extract directory
    chdir($curr_dir);                   // set current working directory to this

    if (isset($stdout)) {
    	if (!$stdouth = fopen($stdout, 'w')) {
    	    trigger_error("Cannot open file $stdout", E_USER_ERROR);
        } // if
        ob_start();  // start output buffering
    } // if

    echo "<html>\n";
    echo '<p>** started at ' .date('F j, Y, g:i a') ."</p>\n";

    // retrieve variables from file
    if (file_exists('batch.ini')) {
    	$ini_array = parse_ini_file('batch.ini');           // use custom file
    } else {
        $ini_array = parse_ini_file('batch.ini.default');   // use default file
    } // if

    $_SERVER['SERVER_NAME'] = $ini_array['server_name'];
    $_SERVER['DOCUMENT_ROOT'] = str_replace("\\", "/", $ini_array['doc_root']);
    $_SERVER['HTTP_ACCEPT_LANGUAGE'] = $ini_array['language'];
    $_SERVER['SCRIPT_FILENAME'] = $curr_file;
    $_SERVER['REMOTE_ADDR'] = 'batch';
    $_SERVER['REQUEST_URI'] = $curr_file;
    if (!empty($ini_array['server_admin'])) {
    	$_SERVER['SERVER_ADMIN'] = $ini_array['server_admin'];
    } // if

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
    	    if (strtolower(substr($string, 0, 9)) == 'php_value') {
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
    	unset($fn);
    } // if
    if (empty($include_path)) {
    	ini_set('include_path', $ini_array['include_path']);
    } // if
    
    if (file_exists('user.ini')) {
        $fn = 'user.ini';
    } elseif (file_exists('.user.ini')) {
        $fn = '.user.ini';
    } // if
    if (!empty($fn)) {
        // alternative to htaccess when run as CGI/FastCGI
        $ini_array = parse_ini_file($fn);
        foreach ($ini_array as $key => $value) {
            if ($key == 'include_path') {
                if (substr($value, 0, 1) == ';') {
                    // append to current value
                    $value = ini_get('include_path').$value;
                } // if
            } // if
        	$result = ini_set($key, $value);
        } // foreach
        unset($fn);
    } //

    echo '<p>script name  : ' .$curr_file ."</p>\n";
    echo '<p>document root: ' .$_SERVER['DOCUMENT_ROOT'] ."</p>\n";
    echo '<p>server name  : ' .$_SERVER['SERVER_NAME'] ."</p>\n";
    echo '<p>server API   : ' .php_sapi_name() ."</p>\n";
    echo '<p>language     : ' .$_SERVER["HTTP_ACCEPT_LANGUAGE"] ."</p>\n";
    echo '<p>server_admin : ' .$_SERVER["SERVER_ADMIN"] ."</p>\n";

    $PHP_SELF = str_replace($_SERVER['DOCUMENT_ROOT'], "", $curr_file);
    $_SERVER['PHP_SELF'] = $PHP_SELF;

    $_SESSION['role_id']       = 'batch';
    $_SESSION['logon_user_id'] = 'batch';
    $GLOBALS['task_id']        = basename($PHP_SELF);
    $GLOBALS['batch']          = true;
    $GLOBALS['mode']           = 'batch';

    require_once 'include.general.inc';
    require_once 'include.session.inc';

    echo '<p>include_path : ' .ini_get('include_path') ."</p>\n";

    if (isset($stdout)) {
        $output = ob_get_contents();
        if (!$result = fwrite($stdouth, $output)) {
            trigger_error("Cannot write to file $stdout", E_USER_ERROR);
        } // if
        ob_flush();                 // flush current output
    } // if

} // batchInit

// ****************************************************************************
function batchEnd ($errors=null)
//
{
    if (!empty($errors)) {
    	if (is_array($errors)) {
    		foreach ($errors as $key => $value) {
    			echo "<p>[" .$key ."] " .$value ."</p>\n";
    		} // foreach
    	} elseif (is_string($errors)) {
    	    echo "<p>$errors</p>\n";
    	} // if
    } // if

    echo '<p>** finished at ' .date('F j, Y, g:i a') ."</p>\n";
    echo "</html>";

    global $stdout, $stdouth;

    if (isset($stdout)) {
    	$output = ob_get_contents();
        if (!$result = fwrite($stdouth, $output)) {
            trigger_error("Cannot write to file $stdout", E_USER_ERROR);
        } // if
        ob_flush();                 // flush current output
        fclose($stdouth);
    } // if

    echo "<p>Done!</p>";

    return;

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
