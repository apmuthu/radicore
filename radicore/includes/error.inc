<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// This is my universal error handler.

// It can be called using code such as:
// ..do something.. or trigger_error("message", E_USER_ERROR);

// tell system what function to use as the error handler
set_error_handler('errorHandler');

$GLOBALS['xslt_error']  = null;

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
    if ($errno != E_STRICT) {
        if (function_exists('debugBreak') AND defined("DEBUGBREAK_ON_ERROR")) {
            debugBreak();
        } // if
    } // if

    //logstuff("error: " .'(' .$errno .') ' .$errstr, $errfile, $errline);

    switch ($errno) {
        case E_USER_WARNING:
        case E_USER_NOTICE:
        case E_WARNING:
            if (isset($errcontext['this']) AND is_object($errcontext['this'])) {
                if ($errcontext['this'] instanceof mysql) {
                    $errno  = $errcontext['this']->getErrorNo();
                    if ($errno <> 0) {
                        break;
                    } // if
                } elseif ($errcontext['this'] instanceof pgsql) {
                    $errno  = $errcontext['this']->getErrorNo();
                    if ($errno <> 0) {
                        break;
                    } // if
                } elseif ($errcontext['this'] instanceof oracle) {
                    $errno  = $errcontext['this']->getErrorNo();
                    if ($errno <> 0) {
                        if ($errno == 1002) {
                             // "fetch out of sequence" - IGNORE
                             $errcontext['this']->error_string = null;
                        } else {
                            break;
                        } // if
                    } // if
                } elseif ($errcontext['this'] instanceof sqlsrv) {
                    $errno  = $errcontext['this']->getErrorNo();
                    if ($errno <> 0) {
                        break;
                    } // if
                } else {
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
            } elseif (isset($GLOBALS['batch']) AND preg_match('/^(require)/i', $errstr)) {
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
            // save error details before returning
            $GLOBALS['php_errorno']   = $errno;
            $GLOBALS['php_errormsg']  = $errstr;
            $GLOBALS['php_errorfile'] = $errfile;
            $GLOBALS['php_errorline'] = $errline;
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

    if (isset($GLOBALS['batch']) AND is_True($GLOBALS['batch'])) {
    	// skip the next bit
    } else {
        if (function_exists('XMLRPC_errorhandler')) {
            // this is within XML-RPC or SOAP server, so skip next bit
        } else {
        	if (!isset($_SESSION)) {
                session_start();
            } // if
        } // if
    } // if

    if (!defined('RDC_WITHIN_ERROR_HANDLER')) {
        // flag which tells getLanguageText() not to error if entry not found
    	define('RDC_WITHIN_ERROR_HANDLER', true);
    } // if

    $errorstring = "<div class='error'>\n";
    $errorstring .= "<h2>" . date('Y-m-d H:i:s') . "</h2>\n";
    //$errorstring .= "<p>Fatal Error: $errstr (# $errno).</p>\n";
    $errorstring .= "<p>" .getLanguageText('sys0063', $errstr);
    if (!empty($errno)) {
    	$errorstring .= " (# $errno)";
    } // if
    $errorstring .= "</p>\n";
    if (!empty($query)) {
        //$errorstring .= "<p>SQL query: $query</p>\n";
        $errorstring .= "<p>" .getLanguageText('sys0064', $query) ."</p>\n";
    } // if
    //$errorstring .= "<p>Error in line $errline of file '$errfile'.</p>\n";
    $errorstring .= "<p>" .getLanguageText('sys0065', $errline, $errfile) ."</p>\n";
    if (!empty($errstr2)) {
    	$errorstring .= "<p>" .$errstr2 ."</p>\n";
    } // if
    //$errorstring .= "<p>PHP_SELF: '{$_SERVER['PHP_SELF']}'.</p>\n";
    $errorstring .= "<p>" .getLanguageText('sys0066', $_SERVER['PHP_SELF']) ."</p>\n";
    //$errorstring .= "<p>CURRENT DIRECTORY: " .getcwd() ."</p>\n";
    $errorstring .= "<p>" .getLanguageText('sys0187', getcwd()) ."</p>\n";

    $ip_address = getRealIPAddress();
    if (!empty($ip_address)) {
        //$errorstring .= "<p>SERVER_ADDR: '{$_SERVER['SERVER_ADDR']}'.</p>\n";
    	$errorstring .= "<p>" .getLanguageText('sys0183', $ip_address) ."</p>\n";
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
    if (isset($_SESSION['role_id'])) {
        //$errorstring .= "<p>Role Id: {$_SESSION['role_id']}</p>\n";
        $errorstring .= "<p>" .getLanguageText('sys0109', $_SESSION['role_id']) ."</p>\n";
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
    $errorstring .= "</div>\n";

    global $page_stack;
    //$history = "<p>" .'Page Stack:' ."</p>\n";
    $history  = "<p>" .getLanguageText('sys0073') ."</p>\n";
    $ix = 0;
    if ($page_stack) {
        $history .= "<pre>\n";
        foreach ($page_stack as $script => $text) {
        	$history .= '  [' .$ix .'] ' .$script ."\n";
        	$ix++;
        } // foreach
        $history .= "</pre>\n";
    } // if

    // retrieve and format debug_backtrace for output
    if (isset($errcontext['exception'])) {
        $result = $errcontext['exception']->getTrace();
    } else {
        $result = debug_backtrace();
    } // if
    //$trace_hdg = "<p>Backtrace:</p>\n";
    $trace_hdg  = "<p>" .getLanguageText('sys0075') ."</p>\n";
    $trace     = null;
    foreach ($result as $level => $string) {
        $trace .= "$level: array =\n";
        if (is_array($string)) {
            $trace = print_Trace($level, $string, $trace);
        } // if
    } // foreach

    // remove all html tags for email message
    $search = array('<br>', '<p>', '</p>', '<pre>', '</pre>');
    $mailstring  = strip_tags($errorstring);
    $mailstring .= str_replace($search, '', $history);
    $mailstring .= str_replace($search, '', $trace_hdg);
    $mailstring .= $trace;
    if (defined('ERROR_LOG_MAILTO')) {
    	$mailto = ERROR_LOG_MAILTO;
    } elseif (!empty($_SERVER['SERVER_ADMIN'])) {
        $mailto = $_SERVER['SERVER_ADMIN'];
    } else {
        $mailto = "webmaster@{$_SERVER['HTTP_HOST']}";
    } // if
    // Send the error to the administrator by email
    $headers = "From: webmaster@{$_SERVER['HTTP_HOST']}";
    $headers .= "\nContent-Type: text/plain; charset=UTF-8";
    $res = error_log($mailstring, 1, $mailto, $headers);

    //echo "<h1>This application has encountered an unrecoverable error</h1>\n";
    $header = "<h1>" .getLanguageText('sys0060') ."</h1>\n";
    //echo "<p>The following has been reported to the administrator:</p>\n";
    $header .= "<p>"  .getLanguageText('sys0061') ."</p>\n";

    $errorstring = $header .$errorstring;

    if (function_exists('XMLRPC_errorhandler')) {
        // this is within an XML-RPC or SOAP server, so skip next bit
    } else {
        if (preg_match('/^(127.0.0.1|localhost|desktop|laptop)$/i', $_SERVER['SERVER_NAME'])
        OR  preg_match('/^(local\.)/i', $_SERVER['SERVER_NAME'])
        OR (isset($GLOBALS['mode']) AND $GLOBALS['mode'] == 'batch')) {
?>
<!DOCTYPE HTML SYSTEM>
<HTML>
<HEAD>
<TITLE>RADICORE</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<STYLE type="text/css">
<!--
  .error h2, .error p {
    color: red;
    font-weight: bold;
  }
-->
</STYLE>
</HEAD>
<BODY>
<?php echo $errorstring."\n"; ?>
</BODY>
</HTML>
<?php
        } else {
            //echo "<p>This application has encountered an unrecoverable error</p>";
            echo '<p>' .getLanguageText('sys0060') .'<br>';
            //echo "<p>Please contact your system administrator for details</p>";
            echo getLanguageText('sys0149') ."</p>\n";
        } // if
    } // if

    global $stdouth;  // handle for stdout
    if (isset($stdouth) AND ob_get_length() !== false) {
        $output = ob_get_contents();
        if (!$result = fwrite($stdouth, $output)) {
            trigger_error("Cannot write to file $stdout", E_USER_ERROR);
        } // if
        ob_flush();                 // flush current output
    } // if

    // remove line breaks
    //$errorstring = str_replace("\n", "", $errorstring);
    //$errorstring .= "\n"; // except the last one

    // add message to log file
    if (defined('ERROR_LOG')) {
    	$logfile = ERROR_LOG;  // write into specified file
    } elseif (defined('ERROR_LOG_DIR')) {
    	$logfile = ERROR_LOG_DIR.'/errorlog.html';  // write into specified directory
    } else {
        $logfile = $_SERVER['DOCUMENT_ROOT'].getParentDIR().'/error_logs/errorlog.html';  // write into default file
    } // if
    error_log("$errorstring\n$history\n$trace_hdg<pre>\n" .htmlspecialchars($trace, ENT_COMPAT, 'UTF-8') ."\n</pre>", 3, $logfile);

    // rollback any incomplete transaction
    if (isset($errcontext['this'])) {
        if (is_object($errcontext['this'])) {
            if (method_exists($errcontext['this'], 'rollback')) {
                if (isset($errcontext['this']->schema)) {
                	$dbname = $errcontext['this']->schema;
                } elseif (isset($errcontext['this']->dbname)) {
                    $dbname = $errcontext['this']->dbname;
                } else {
                    $dbname = null;
                } // if
                if (!empty($dbname)) {
                    $errcontext['this']->rollback($dbname);
                } // if
            } // if
        } // if
    } // if

    $GLOBALS['transaction_has_started'] = FALSE;

    if (isset($GLOBALS['batch']) AND is_True($GLOBALS['batch'])) {
    	// skip the next bit
    } else {
        if (isset($logon_user_id) AND !preg_match('/(internet|batch)/i', $logon_user_id)) {
            // log the current user off
            if (!class_exists('logon')) {
            	require_once 'classes/logon.class.inc';
            } // if
            $dbobject = new logon;
            $errors = $dbobject->user_logoff($logon_user_id);
        } // if
    } // if

    if (isset($GLOBALS['batch']) AND is_True($GLOBALS['batch'])) {
        // continue
    } elseif (isset($logon_user_id) AND preg_match('/(internet|batch)/i', $logon_user_id)) {
        // continue
    } else {
        if (!empty($_SESSION)) {
        	@session_destroy();
            @session_unset();    // clear current session data
        } // if
    } // if

    if (function_exists('XMLRPC_errorhandler')) {
        // this is within XML-RPC or SOAP server, so send message back to client
    	XMLRPC_errorhandler();
    } // if

    die();

} // errorHandler

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

        $string .= ', code='.$exception->getCode();
        $string .= ', file='.$exception->getFile();
        $string .= ', line='.$exception->getLine();

        trigger_error($string, E_USER_ERROR);

    } // exception_handler

    set_exception_handler('exception_handler');

} // if

// ****************************************************************************

?>
