<?php
// ****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2017 by Radicore Software Limited <http://www.radicore.org>
// ****************************************************************************

// this performs initialisation for a batch process (run from command line)

// ****************************************************************************
function batchInit ($batchfile)
// initialisation for a batch process
{
    global $stdout, $stdouth, $argv;

    error_reporting(-1);                // report everything
    ini_set('display_errors', true);    // display everything

    $result = ini_set('max_execution_time', 0);  // no time limit

    set_error_handler('errorHandlerBatch');

    // get fully-qualified name of current file
    $curr_file = str_replace("\\", "/", $batchfile);
    $curr_dir  = dirname($curr_file);   // extract directory
    chdir($curr_dir);                   // set current working directory to this

    // retrieve variables from file
    if (file_exists('../batch.ini')) {
    	$ini_array = parse_ini_file('../batch.ini');           // use custom file
        $ini_file  = '../batch.ini';
    } else {
        $ini_array = parse_ini_file('../batch.ini.default');   // use default file
    } // if

    if (isset($stdout) AND !preg_match('~(/dev/null)$~i', $stdout)) {
        if (realpath($stdout) != false) {
            $stdout = realpath($stdout);
        } // if
    	if (!$stdouth = fopen($stdout, 'w')) {
    	    $message = "Error in script ".basename($curr_file)."\n";
    	    $message .= "Cannot open file '$stdout'";
    	    if (!empty($ini_array['server_admin'])) {
    	    	$mailto = $ini_array['server_admin'];
    	    } elseif (!empty($_SERVER['SERVER_ADMIN'])) {
            	$mailto = $_SERVER['SERVER_ADMIN'];
    	    } else {
    	        $mailto = 'webmaster@'.$ini_array['server_name'];
            } // if
            $headers = "From: {$_SERVER['HTTP_HOST']}\r\n";
            @error_log($message, 1, $mailto, $headers);
    	    //trigger_error("Cannot open file $stdout", E_USER_ERROR);
    	    exit;
        } // if
        if (!preg_match('/^WIN/i', PHP_OS)) {
        	$result = @chmod($stdout, 0777);
        } // if
    } // if

    // start output buffering
    if (!ob_start()) {
        trigger_error("Cannot turn on output buffering", E_USER_ERROR);
    } // if

    echo "<html>\n";
    echo '<p>** started at ' .date(DATE_RFC850)."</p>\n";

    $_SERVER['SCRIPT_FILENAME']          = $curr_file;

    if (empty($_SERVER['SERVER_NAME'])) {
    	$_SERVER['SERVER_NAME']          = trim($ini_array['server_name'], "'");
    } // if
    if (empty($_SERVER['HTTP_HOST'])) {
    	$_SERVER['HTTP_HOST']            = trim($ini_array['server_name'], "'");
    } // if
    if (empty($_SERVER['DOCUMENT_ROOT'])) {
    	$_SERVER['DOCUMENT_ROOT']        = str_replace("\\", "/", trim($ini_array['doc_root'], "'"));
    } // if
    $_SERVER['PHP_SELF']                 = str_replace($_SERVER['DOCUMENT_ROOT'], "", $_SERVER['SCRIPT_FILENAME']);
    if (empty($_SERVER['HTTP_ACCEPT_LANGUAGE'])) {
        if (!empty($ini_array['language'])) {
            $_SERVER['HTTP_ACCEPT_LANGUAGE'] = trim($ini_array['language'], "'");
        } else {
            $_SERVER['HTTP_ACCEPT_LANGUAGE'] = 'en';
        } // if
    } // if
    if (empty($_SERVER['REMOTE_ADDR'])) {
    	$_SERVER['REMOTE_ADDR']          = 'batch';
    } // if
    if (empty($_SERVER['SERVER_ADMIN'])) {
        $_SERVER['SERVER_ADMIN']         = ini_get('sendmail_from');
        if (empty($_SERVER['SERVER_ADMIN'])) {
            $_SERVER['SERVER_ADMIN']     = trim($ini_array['server_admin'], "'");
        } // if
    } // if

    if (empty($ini_file)) {
        // look for INCLUDE_PATH in optional htaccess file
        if (file_exists('../htaccess.txt')) {
            $fn = '../htaccess.txt';
        } elseif (file_exists('../.htaccess')) {
            $fn = '../.htaccess';
        } // if
        if (!empty($fn)) {
            $ini_file = $fn;
    	    $handle = fopen($fn, 'r');
    	    while ($string = fgets($handle)) {
    	        $string = trim($string);
    	        if (strtolower(substr($string, 0, 9)) == 'php_value') {
    	    	    list ($php_value, $name, $arg) = explode(' ', $string);
                    if ($name == 'include_path') {
                	    $arg = trim($arg, '".');
                        $ini_array = array('include_path' => $arg);
                        break;
                    } // if
    	        } // if
            } // while
    	    fclose($handle);
    	    unset($fn);
        } // if
    } // if

    if (empty($include_path) AND !empty($ini_array['include_path'])) {
    	ini_set('include_path', trim($ini_array['include_path'], "'"));
    } // if

    if (empty($ini_file)) {
        if (file_exists('../user.ini')) {
            $fn = '../user.ini';
        } elseif (file_exists('../.user.ini')) {
            $fn = '../.user.ini';
        } // if
        if (!empty($fn)) {
            // alternative to htaccess when run as CGI/FastCGI
            $ini_array = parse_ini_file($fn);
            foreach ($ini_array as $key => $value) {
                $value = trim($value, "'");
                if ($key == 'include_path') {
                    if (substr($value, 0, 1) == ';') {
                        // append to current value
                        $value = ini_get('include_path').$value;
                        break;
                    } // if
                } // if
        	    $result = ini_set($key, $value);
            } // foreach
            unset($fn);
        } // if
    } // if

    echo '<p>server name  : ' .$_SERVER['SERVER_NAME'] ."</p>\n";
    echo '<p>document root: ' .$_SERVER['DOCUMENT_ROOT'] ."</p>\n";
    echo '<p>script name  : ' .$_SERVER['SCRIPT_FILENAME'] ."</p>\n";
    echo '<p>php_self     : ' .$_SERVER['PHP_SELF'] ."</p>\n";
    echo '<p>server API   : ' .php_sapi_name() ."</p>\n";
    echo '<p>language     : ' .$_SERVER["HTTP_ACCEPT_LANGUAGE"] ."</p>\n";
    echo '<p>server_admin : ' .$_SERVER["SERVER_ADMIN"] ."</p>\n";

    $_SESSION['logon_user_id'] = 'batch';   // default - may be replaced if session data is read
    $_SESSION['role_id']       = 'batch';   // default - may be replaced if session data is read
    $_SESSION['rdcaccount_id'] = 1;         // default - may be replaced if session data is read
    $GLOBALS['task_id']        = basename($_SERVER['PHP_SELF']);
    $GLOBALS['batch']          = true;
    $GLOBALS['mode']           = 'batch';

    $_SESSION['default_language'] = 'en';  // default

    //checkFileExists('include.general.inc');
    require_once 'include.general.inc';
    //checkFileExists('include.session.inc');
    require_once 'include.session.inc';

    echo '<p>include_path : ' .ini_get('include_path') ."</p>\n";
    echo '<p>project_code : ' .$GLOBALS["project_code"] ."</p>\n";

    if (!empty($argv)) {
        $count = count($argv)-1;
        for ($i=1;$i<=$count;$i++) {
            echo "<p>ARGV[$i]={$argv[$i]}</p>\n";
        } // for
    } // if

    if (!empty($_SERVER['SERVER_PROTOCOL']) OR !empty($argv)) {
        initSession(null, $argv);
    } // if

    if (empty($where) AND !empty($argv[3])) {
        $where = $argv[3];
    } // if
    if (empty($selection) AND !empty($argv[4])) {
        $selection = $argv[4];
    } // if
    if (empty($search) AND !empty($argv[5])) {
        $search = $argv[5];
    } // if
    if (empty($settings) AND !empty($argv[6])) {
        $settings = $argv[6];
    } // if
    unset($argv);

    if (empty($_SESSION['role_list'])) {
        if (defined('TRANSIX_NO_MENU') OR defined('RADICORE_NO_MENU')) {
            $data = array();
        } else {
            $dbobject = RDCsingleton::getInstance('menu/mnu_user_role');
            $data = $dbobject->getData("user_id='{$_SESSION['logon_user_id']}'");
        } // if
        if (!empty($data)) {
            $role_array = array();
            foreach ($data as $rowdata) {
                $role_array[] = $rowdata['role_id'];
            } // foreach
            $role_list = "'".implode("','", $role_array)."'";
            $_SESSION['role_list'] = $role_list;
        } else {
            $_SESSION['role_list'] = "'{$_SESSION['role_id']}'";
        } //if
        unset($dbobject);
    } // if

    echo '<p>user_id  : ' .$_SESSION['logon_user_id'] ."</p>\n";
    echo '<p>role_id  : ' .$_SESSION['role_id'] ."</p>\n";
    echo '<p>role_list: ' .$_SESSION['role_list'] ."</p>\n";

    global $where, $selection, $search;

    echo "<p>WHERE     : {$where}\n";
    echo "<br>SELECTION: {$selection}\n";
    echo "<br>SEARCH   : {$search}</p>\n";

    if (isset($stdouth)) {
        $output = ob_get_contents();
        $result = fwrite($stdouth, $output);
        if ($result === false) {
            trigger_error("Cannot write to file $stdout", E_USER_ERROR);
        } // if
        ob_flush();
    } else {
        ob_end_clean();
        ob_start();
    } // if

    return;

} // batchInit

// ****************************************************************************
function batchEnd ($errors=null)
// end batch processing
{
    if (!empty($errors)) {
        $string = errors2string($errors, '<p>', "</p>");
        echo $string;
    } // if

    $errors = batchScriptSequence();  // process anything put in $_SESSION['script_sequence']

    //echo '<p>** finished at ' .date('F j, Y, ').getTimeStamp('time') ."</p>\n";
    echo '<p>** finished at ' .date(DATE_RFC850)."</p>\n";

    echo "</html>";

    global $stdout, $stdouth;

    if (isset($stdouth)) {
        $output = ob_get_contents();
        $result = fwrite($stdouth, $output);
        if ($result === false) {
            trigger_error("Cannot write to file $stdout", E_USER_ERROR);
        } // if
        ob_flush();
        fclose($stdouth);
    } else {
        ob_end_clean();
    } // if

    return;

} // batchEnd

// ****************************************************************************
function batchScriptSequence ()
// process $_SESSION['script_sequence'] when running in batch mode.
{
    if (!isset($_SESSION) OR !isset($_SESSION['script_sequence'])) {
        return;
    } // if

    $script_sequence = $_SESSION['script_sequence'];
    unset($_SESSION['script_sequence']);
    //session_write_close();

    $errors = array();

    while (!empty($script_sequence)) {
        $next = array_shift($script_sequence);
        $task_id = $next['task_id'];
        $where   = $next['where'];

        echo "<p>INITIATING TASK: {$task_id}, WHERE: {$where} </p>\n";

        $task_array['settings'] = 'rdc_wait=Y';
        $errors = scriptNext($task_id, $where, null, $task_array);
        if ($errors) {
            foreach ($errors as $key => $value) {
                echo "<p>[" .$key ."] " .$value ."</p>\n";
            } // foreach
            break;
        } // if
    } // while

    return $errors;

} // batchScriptSequence

// ****************************************************************************
function check_errors ($object)
// check object for errors and terminate if any are found.
// output any messages without terminaing.
{
    global $stdout, $stdouth;

    $errors = $object->getErrors();

	if (!empty($errors)) {
	    if (!empty($object->query)) {
	        // append database query to array
        	$errors['query'] = $object->query;
        } // if

        if (isset($GLOBALS['initial_values_task_id']) AND !empty($GLOBALS['initial_values_task_id'])) {
            $errors['initial_values_task_id'] = $GLOBALS['initial_values_task_id'];
        } // if

        // $errors should be an associative array, but it may be indexed
        $array_in  = $errors;
        $array_out = array();
	    foreach ($array_in as $ix1 => $error1) {
            $array_out[] = format_array($error1, '['.$ix1.']');
	    } // foreach
	    $errors = $array_out;
	    unset($array_in, $array_out, $ix1, $ix2, $error1);

        if (method_exists($object, 'rollback')) {
	        $object->rollback();
        } // if

        $output = format_array($errors);
        send_to_stdout($output);

        if (method_exists($object, 'getFieldArray')) {
            $objectData = $object->getFieldArray();
            if (!empty($objectData)) {
                $output = "DATA:<br>".format_array($objectData);
                send_to_stdout($output);
            } // if
        } // if

	    // put first error into $string
        $string = array_shift($errors);

	    trigger_error($string, E_USER_ERROR);
	} // if

    if (method_exists($object, 'getMessages')) {
	    // deal with any non-fatal messages
	    $messages = $object->getMessages();
	    foreach ($messages as $message) {
            send_to_stdout($message);
	    } // foreach
    } // if

	return;

} // check_errors

// ****************************************************************************
function check_warnings ($object)
// check object for warnings and display any that are found
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
function checkFileExists ($fname)
// check that file $fname exists on current include_path, and abort if it doesn't.
{
    if (!@fopen($fname, 'r', true)) {
        $message = "** Cannot find file '$fname' **";
        trigger_error($message, E_USER_ERROR);
    } // if

    return true;

} // checkFileExists

// ****************************************************************************
function send_to_stdout($message, $prefix="<p>", $suffix="</p>\n")
// either echo the string or write it to stdout
{
    global $stdout, $stdouth;

    $message = $prefix.$message.$suffix;

    if (preg_match('~(/dev/null)$~i', $stdout)) {
        // all out is suppressed
    } else {
        if (empty($stdout)) {
            echo $message;
        } else {
            $result = fwrite($stdouth, $message);
        } // if
    } // if

    return;

} // send_to_stdout

// ****************************************************************************
function errorHandlerBatch ($errno, $errstr, $errfile, $errline, $errcontext)
// This is a temporary error handler until the real one (error.inc) is activated.
{
    switch ($errno) {
        case E_USER_WARNING:
        case E_USER_NOTICE:
        case E_WARNING:
            if (isset($GLOBALS['batch']) AND preg_match('/^(require)/i', $errstr)) {
                // detected a failed 'require()' in a batch job, so abort now
                break;
            } // if
        case E_NOTICE:
        case E_CORE_WARNING:
        case E_COMPILE_WARNING:
        case E_STRICT;
        case E_RECOVERABLE_ERROR;
        case E_DEPRECATED;
        case E_USER_DEPRECATED;
            return;
        case E_USER_ERROR:
        case E_ERROR:
        case E_PARSE:
        case E_CORE_ERROR:
        case E_COMPILE_ERROR:
        default:
            break;
    } // switch

    global $stdout, $stdouth;

    $output = ob_get_contents();
    $output .= "<p>**** ERROR ****</p>\n";
    $output .= "<p>$errstr</p>\n";
    $output .= "<p>File: $errfile, Line: $errline</p>\n";

    if (isset($stdout)) {
        $result = fwrite($stdouth, $output);
        fclose($stdouth);
    } else {
        echo $output;
    } // if

    ob_flush();  // flush current output

    die();

} // errorHandlerBatch

// ****************************************************************************
?>
