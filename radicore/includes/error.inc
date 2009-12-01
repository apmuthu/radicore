<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2009 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// This is my universal error handler.

// It can be called using code such as:
// ..do something.. or trigger_error("message", E_USER_ERROR);

// tell system what function to use as the error handler
set_error_handler('errorHandler');

$xslt_error  = null;

if (version_compare(phpversion(), '5.0.0', '<')) {
    // these do not exist in PHP 4, so define them manually
    define('E_STRICT', 2048);
    define('E_RECOVERABLE_ERROR', 4096);
    define('E_DEPRECATED', 8192);
    define('E_USER_DEPRECATED', 16384);
} else {
    // new constants were added in new versions of PHP 5
    if (version_compare(phpversion(), '5.2.0', '<')) {
        // this does not exist before 5.2, so define manually
        define('E_RECOVERABLE_ERROR', 4096);
    } // if
    if (version_compare(phpversion(), '5.3.0', '<')) {
        // these do not exist before 5.3, so define manually
        define('E_DEPRECATED', 8192);
        define('E_USER_DEPRECATED', 16384);
    } // if
} // if

// ****************************************************************************
function errorHandler ($errno, $errstr, $errfile, $errline, $errcontext)
// If the error condition is E_USER_ERROR or above then abort
{
    if ($errno != E_STRICT AND $errno != E_DEPRECATED) {
        if (function_exists('debugger_start_debug')) {
            //debugger_connect();
            //debugger_start_debug();
        } // if
        $breakpoint = 'breakpoint';
    } // if

    //logstuff("error: " .'(' .$errno .') ' .$errstr, $errfile, $errline);

    switch ($errno) {
        case E_USER_WARNING:
        case E_USER_NOTICE:
        case E_WARNING:
            if (isset($errcontext['this']) AND is_object($errcontext['this'])) {
                // context is an object, but does it have a variable called $error_string?
                if (method_exists($errcontext['this'], 'getErrorString')) {
                    // yes, but does it contain an error message?
                    $message = $errcontext['this']->getErrorString();
                    if (!empty($message)) {
                        $errstr = $message;
                        break;
                    } // if
                } // if
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

    if (isset($_SESSION['logon_user_id'])) {
        $logon_user_id = $_SESSION['logon_user_id'];
    } // if

    if (isset($errcontext['this']) AND is_object($errcontext['this'])) {
        // retrieve error details from DML object
        if (method_exists($errcontext['this'], 'getQuery')) {
            $query  = $errcontext['this']->getQuery();
        } // if
        if (method_exists($errcontext['this'], 'getErrorNo')) {
            $errno  = $errcontext['this']->getErrorNo();
        } // if
        if (method_exists($errcontext['this'], 'getErrorString')) {
            $errstr = $errcontext['this']->getErrorString();
        } // if
        if (method_exists($errcontext['this'], 'getErrorString2')) {
            $errstr2 = $errcontext['this']->getErrorString2();
        } // if
    } // if

    if (!isset($GLOBALS['batch']) OR !is_True($GLOBALS['batch'])) {
        if (function_exists('XMLRPC_errorhandler')) {
            // this is within XML-RPC or SOAP server, so skip next bit
        } else {
        	if (!isset($_SESSION)) {
                session_start();
            } // if
        } // if
    } // if

    $errorstring = "<h2>" . date('Y-m-d H:i:s') . "</h2>\n";
    //$errorstring .= "<p>Fatal Error: $errstr (# $errno).</p>\n";
    $errorstring .= "<p>" .getLanguageText('sys0063', $errstr);
    if (!empty($errno)) {
    	$errorstring .= " (# $errno)";
    } // if
    $errorstring .= ".</p>\n";
    //if ($query) $errorstring .= "<p>SQL query: $query</p>\n";
    if (!empty($query)) {
        $errorstring .= "<p>" .getLanguageText('sys0064', $query) ."</p>\n";
    } // if
    //$errorstring .= "<p>Error in line $errline of file '$errfile'.</p>\n";
    $errorstring .= "<p>" .getLanguageText('sys0065', $errline, $errfile) ."</p>\n";
    if (!empty($errstr2)) {
    	$errorstring .= "<p>" .$errstr2 ."</p>\n";
    } // if
    //$errorstring .= "<p>PHP_SELF: '{$_SERVER['PHP_SELF']}'.</p>\n";
    $errorstring .= "<p>" .getLanguageText('sys0066', $_SERVER['PHP_SELF']) ."</p>\n";

    if (!empty($_SERVER['SERVER_ADDR'])) {
        //$errorstring .= "<p>SERVER_ADDR: '{$_SERVER['SERVER_ADDR']}'.</p>\n";
    	$errorstring .= "<p>" .getLanguageText('sys0183', $_SERVER['SERVER_ADDR']) ."</p>\n";
    } // if
    if (!empty($_SERVER['SERVER_NAME'])) {
    	//$errorstring .= "<p>SERVER_NAME: '{$_SERVER['SERVER_NAME']}'.</p>\n";
        $errorstring .= "<p>" .getLanguageText('sys0184', $_SERVER['SERVER_NAME']) ."</p>\n";
    } // if
    if (!empty($_SERVER['HTTP_HOST'])) {
    	//$errorstring .= "<p>HTTP_HOST: '{$_SERVER['HTTP_HOST']}'.</p>\n";
        $errorstring .= "<p>" .getLanguageText('sys0185', $_SERVER['HTTP_HOST']) ."</p>\n";
    } // if

    if (isset($logon_user_id)) {
        //$errorstring .= "<p>User Id: {$_SESSION['logon_user_id']}</p>\n";
        $errorstring .= "<p>" .getLanguageText('sys0067', $logon_user_id) ."</p>\n";
    } // if

    if (!empty($_SERVER['REMOTE_ADDR'])) {
    	//$errorstring .= "<p>REMOTE_ADDR: {$_SERVER['REMOTE_ADDR']}</p>\n";
        $errorstring .= "<p>" .getLanguageText('sys0068', $_SERVER['REMOTE_ADDR']) ."</p>\n";
    } // if
    if (!empty($_SERVER['REMOTE_HOST'])) {
    	//$errorstring .= "<p>REMOTE_HOST: {$_SERVER['REMOTE_HOST']}</p>\n";
        $errorstring .= "<p>" .getLanguageText('sys0186', $_SERVER['REMOTE_HOST']) ."</p>\n";
    } // if
    if (!empty($_SERVER['REQUEST_URI'])) {
    	//$errorstring .= "<p>REQUEST_URI: {$_SERVER['REQUEST_URI']}</p>\n";
        $errorstring .= "<p>" .getLanguageText('sys0069', $_SERVER['REQUEST_URI']) ."</p>\n";
    } // if

    global $page_stack;
    //$history = "<p>" .'Page Stack:' ."</p>\n";
    $history = "<p>" .getLanguageText('sys0073') ."</p>\n";
    $history .= "<pre>\n";
    $ix = 0;
    if ($page_stack) {
        foreach ($page_stack as $script => $text) {
        	$history .= '  [' .$ix .'] ' .$script ."\n";
        	$ix++;
        } // foreach
    } // if
    $history .= "\n</pre>\n";

    // retrieve and format debug_backtrace for output
    if (isset($errcontext['exception'])) {
        $trace = $errcontext['exception']->getTrace();
    } else {
        $trace = debug_backtrace();
    } // if
    $result = null;
    foreach ($trace as $level => $string) {
        $result .= "$level: array =\n";
        if (is_array($string)) {
            $result = print_Trace($level, $string, $result);
        } // if
    } // foreach

    //$result = "<pre>\n" .$result ."\n</pre>\n";

//    if (preg_match('/^(127.0.0.1|localhost|desktop|laptop)$/i', $_SERVER['SERVER_NAME'])) {
//        // my development PC does not have 'sendmail', so do nothing
//    } else {
        // remove all html tags
        $search = array('<br>', '<p>', '</p>', '<h2>', '</h2>');
        $mailstring = str_replace($search, '', "$errorstring $history");
        // Send the error to the administrator by email
        $headers = "From: {$_SERVER['HTTP_HOST']}\r\n";
        @error_log("$mailstring <pre>\n$result\n</pre>\n", 1, $_SERVER['SERVER_ADMIN'], $headers);
//    } // if

    //echo "<h2>This application has encountered an unrecoverable error</h2>\n";
    $header = "<h2>" .getLanguageText('sys0060') ."</h2>\n";
    //echo "<p>The following has been reported to the administrator:</p>\n";
    $header .= "<p>"  .getLanguageText('sys0061') ."</p>\n";

    $errorstring = "$header\n<b><font color='red'>\n$errorstring\n</font></b>";

    if (function_exists('XMLRPC_errorhandler')) {
        // this is within XML-RPC or SOAP server, so skip next bit
    } else {
        if (preg_match('/^(127.0.0.1|localhost|desktop|laptop)$/i', $_SERVER['SERVER_NAME'])) {
            echo $errorstring;
        } else {
            // "This application has encountered an unrecoverable error"
            echo '<p>' .getLanguageText('sys0060') .'<br>';
            // "Please contact your system administrator for details"
            echo getLanguageText('sys0149') .'</p>';
        } // if
    } // if

    global $stdouth;
    if (isset($stdouth) AND ob_get_length() !== false) {
        $output = ob_get_contents();
        if (!$result = fwrite($stdouth, $output)) {
            trigger_error("Cannot write to file $stdout", E_USER_ERROR);
        } // if
        ob_flush();                 // flush current output
    } // if

    // remove line breaks
    $errorstring = str_replace("\n", "", $errorstring);
    $errorstring .= "\n"; // except the last one

    // add message to log file
    if (dirname($_SERVER['SCRIPT_FILENAME']) == $_SERVER['DOCUMENT_ROOT']) {
        // this is the highest directory, so use it
    	$logfile = 'errorlog.html';
    } else {
        // write into parent directory
        $logfile = '../errorlog.html';
    } // if
    error_log("$errorstring $history <pre>\n" .htmlspecialchars($result, ENT_COMPAT, 'UTF-8') ."\n</pre>", 3, $logfile);

    // rollback any incomplete transaction
    if (isset($errcontext['this'])) {
        if (is_object($errcontext['this'])) {
            if (method_exists($errcontext['this'], 'rollback')) {
                if (isset($errcontext['this']->schema)) {
                	$dbname = $errcontext['this']->schema;
                } else {
                    $dbname = $errcontext['this']->dbname;
                } // if
                $errcontext['this']->rollback($dbname);
            } // if
        } // if
    } // if

    $GLOBALS['transaction_has_started'] = FALSE;

    if (isset($logon_user_id) AND !preg_match('/INTERNET|BATCH/i', $logon_user_id)) {
        // log the current user off
        if (!class_exists('logon')) {
        	require_once 'classes/logon.class.inc';
        } // if
        $dbobject = new logon;
        $errors = $dbobject->user_logoff($logon_user_id);
    } // if

    if (isset($GLOBALS['batch']) AND is_True($GLOBALS['batch'])) {
        // continue
    } elseif (isset($logon_user_id) AND $logon_user_id == 'INTERNET') {
        // continue
    } else {
        if (!empty($_SESSION)) {
        	session_destroy();
            session_unset();    // clear current session data
        } // if
    } // if

    if (function_exists('XMLRPC_errorhandler')) {
        // this is within XML-RPC or SOAP server, so send message back to client
    	XMLRPC_errorhandler();
    } // if

    die();

} // errorHandler

// *****************************************************************************
function print_Trace ($level, $string, $result, $indent=null)
// output a segment of the array produced by debug_backrace()
{
    $indent .= '  ';    // increase indent by 2 spaces
    foreach ($string as $level2 => $string2) {
        $pattern = '/'                      // begin pattern
                 . '^(HTTP_[a-z]+_VARS)$'   // HTTP_xxxx_VARS
                 . '|'                      // or
                 . '^(HTTP_[a-z]+_FILES)$'  // HTTP_xxxx_FILES
                 . '|'                      // or
                 . '^(_[a-z]+)$'            // _xxxx
                 . '|'                      // or
                 . '^GLOBALS$'              // GLOBALS
                 . '/i';                    // end pattern, case insensitive
        if (preg_match($pattern, $level2, $regs)) {
            // ignore
        } else {
        	if (is_array($string2)) {
                if (isset($string2['this'])) {
                    // output class name, but no class properties
                    $class = get_class($string2['this']);
                    $result .= $indent ."$level2: object = $class\n";
                } else {
                    $result .= $indent ."$level2: array =\n";
                    $result = print_Trace($level2, $string2, $result, $indent);
                } // if
        	} elseif (is_object($string2)) {
        	    // do nothing
            } else {
                if (is_null($string2)) {
                	$result .= $indent ."$level2: string = null\n";
                } else {
                    $result .= $indent ."$level2: " .gettype($string2) ." = $string2\n";
                } // if
            } // if
        } // if
    } // foreach

    return $result;

} // print_Trace

// *****************************************************************************
function XML_errorHandler ($errno, $errstr, $errfile, $errline, $errcontext)
// deal with errors from XML or XSL functions.
{
    // pass these details to the standard error handler
    errorHandler (E_USER_ERROR, $errstr, $errfile, $errline, $errcontext);

} // XML_errorHandler

// ****************************************************************************
function XSLT_errorHandler ($parser, $errorno, $level, $fields)
// error handler for Sablotron XSLT process
{
    global $xslt_error;

    $xslt_error = "Error Number $errorno, Level $level, Fields:\n";
    if (is_array($fields)) {
        foreach ($fields as $key => $value) {
            $xslt_error .= "<br> $key => $value\n";
        } // while
    } else {
        $xslt_error .= "<br>$fields";
    } // if

    return;

} // XSLT_errorHandler

// ****************************************************************************
if (version_compare(phpversion(), '5.0.0', '>=')) {
    // only valid if PHP version is 5.0.0 or higher
    // ****************************************************************************
    function exception_handler($exception)
    // catch-all for unhandled exceptions.
    {

        //$string = 'Uncaught exception from ' .get_class($exception) .', message = ' .$exception->getMessage();
        $string = getLanguageText('sys0062', get_class($exception), $exception->getMessage());

        trigger_error($string, E_USER_ERROR);

    } // exception_handler

    set_exception_handler('exception_handler');

} // if

// ****************************************************************************

?>
