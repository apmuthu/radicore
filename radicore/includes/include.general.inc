<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2010 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// This file contains generic settings

if (file_exists('./include.subsystem.inc')) {
    // process optional includes from current subsystem directory
	include('./include.subsystem.inc');
} elseif (file_exists('./include.subsystem.inc.default')) {
    // process optional includes from current subsystem directory
	include('./include.subsystem.inc.default');
} // if

// modify INCLUDE_PATH
$include_path = ini_get('include_path');
$include_path .= PATH_SEPARATOR .'../menu';
$include_path .= PATH_SEPARATOR .'../audit';
$include_path .= PATH_SEPARATOR .'../workflow';
ini_set('include_path', $include_path);

unset($include_path);

$transaction_has_started = false;
if (!isset($use_HTTPS)) {
	$use_HTTPS = false;
} // if

// try to find a copy of CONFIG.INC
if (@fopen('config.inc', 'r', true)) {
    // found in current include_path
	require_once 'config.inc';
} else if (@fopen('../../INCLUDES/config.inc', 'r')) {
    // found in a higher directory
    require_once '../../INCLUDES/config.inc';
} else {
    // not found, so this should error
    require_once 'config.inc';
} // if

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

if (extension_loaded('mbstring')) {
	ini_set('mbstring.internal_encoding', 'UTF-8');
} // if

require_once 'include.library.inc';
//require_once 'include.library.old.inc';

if (isset($_SERVER['SERVER_PROTOCOL'])) {
    $protocol = 'HTTP://';
    require_once 'include.session.inc';
} else {
    // this is being run in batch/cli mode, not from a web server
    $protocol = '';
} // if

$handler = setSessionHandler();
unset($handler);

?>
