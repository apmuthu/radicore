<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// This file contains generic settings

$transaction_has_started = false;
if (!isset($GLOBALS['use_https'])) {
	$GLOBALS['use_https'] = false;
} // if
$GLOBALS['classdir'] = null;

// look for a file which is not in the include_path but is in a higher directory
$alt_config = str_replace("\\", '/', realpath('../../INCLUDES/config.inc'));

if (@fopen('config.local.inc', 'r', true)) {
    // found 'local' version in current include_path
	require_once 'config.local.inc';

} elseif (@fopen('config.inc', 'r', true)) {
    // found 'live' version in current include_path
	require_once 'config.inc';

} elseif (file_exists($alt_config)) {
    // found in a higher directory
    require_once $alt_config;

} else {
    // not found, so this should error
    require_once 'config.inc';
} // if
unset($alt_config);

require_once 'include.library.inc';

if (isset($GLOBALS['project_code']) AND !empty($GLOBALS['project_code'])) {
    // look for an optional INCLUDE file for the current subsystem + project
    $result = includeSubsystemPath ($GLOBALS['project_code']);
} else {
    // look for an optional INCLUDE file for the current subsystem
    $result = includeSubsystemPath ();
} // if

// modify INCLUDE_PATH for standard TRANSIX subsystems
$result = includeTransixPath ();

require_once 'error.inc';
require_once 'language_detection.inc';

// are we using PHP 5, or something earlier?
if (version_compare(phpversion(), '5.0.0', '<')) {
    require_once 'include.xml.php4.inc';
} else {
    // PHP 5 uses different code
    require_once 'include.xml.php5.inc';
} // if

if (ini_get('precision') < 15) {
	$precision = ini_set('precision', 15);
} // if
unset($precision);

if (version_compare(phpversion(), '5.6.0', '<')) {
    if (extension_loaded('mbstring')) {
	    ini_set('mbstring.internal_encoding', 'UTF-8');
    } // if
} // if

if (isset($_SERVER['SERVER_PROTOCOL'])) {
    $GLOBALS['protocol'] = 'HTTP://';
    require_once 'include.session.inc';
} else {
    // this is being run in batch/cli mode, not from a web server
    $GLOBALS['protocol'] = '';
} // if

if (!defined('NO_SESSION_HANDLER')) {
	$handler = setSessionHandler();
	unset($handler);
} // if

?>
