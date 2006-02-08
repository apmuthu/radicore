<?php

// this performs initialisation for a batch process (run from command line)

// ****************************************************************************
function batchInit ($batchfile)
// initialisation for a batch process
{
    echo '<p>** started at ' .date('F j, Y, g:i a') ."</p>\n";

    // get fully-qualified name of current file
    $curr_file = str_replace("\\", "/", $batchfile);
    echo '<p>script name  : ' .$curr_file ."</p>\n";
    $curr_dir  = dirname($curr_file);   // extract directory
    chdir($curr_dir);                   // set current working directory to this

    $ini_array = parse_ini_file('batch.ini'); // retrieve variables from file

    ini_set('include_path', $ini_array['include_path']);
    $_SERVER['SERVER_NAME'] = $ini_array['server_name'];
    $_SERVER['DOCUMENT_ROOT'] = str_replace("\\", "/", $ini_array['doc_root']);

    echo '<p>document root: ' .$_SERVER['DOCUMENT_ROOT'] ."</p>\n";
    echo '<p>server name  : ' .$_SERVER['SERVER_NAME'] ."</p>\n";
    echo '<p>include_path : ' .ini_get('include_path') ."</p>\n";

    $PHP_SELF = str_replace($_SERVER['DOCUMENT_ROOT'], "", $curr_file);
    $_SERVER['PHP_SELF'] = $PHP_SELF;

    $_SESSION['logon_user_id'] = 'batch';
    $GLOBALS['task_id']        = basename($PHP_SELF);
    $GLOBALS['batch']          = true;

    require 'include.general.inc';

} // batchInit

// ****************************************************************************
function batchEnd ()
//
{
    echo '<p>** finished at ' .date('F j, Y, g:i a') ."</p>\n";

} // batchEnd

// ****************************************************************************
function check_errors ($object)
// check object for errors and terminate if any are found
{
    $errors = $object->getErrors();

	if ($errors) {
	    foreach ($errors as $ix => $error) {
	        if (is_string($ix)) {
	        	$error = $ix .': ' .$error;
	        } // if
	    	trigger_error($error, E_USER_ERROR);
	    } // foreach
	} // if

} // check_errors

// ****************************************************************************
?>
