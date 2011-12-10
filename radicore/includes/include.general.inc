<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2011 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// This file contains generic settings

$transaction_has_started = false;
if (!isset($use_HTTPS)) {
	$use_HTTPS = false;
} // if

$alt_config = str_replace("\\", '/', realpath('../../INCLUDES/config.inc'));

if (@fopen('config.local.inc', 'r', true)) {
    // found 'local' version in current include_path
	require_once 'config.local.inc';

} elseif (@fopen('config.inc', 'r', true)) {
    // found 'live' version in current include_path
	require_once 'config.inc';

} elseif (substr($alt_config, 0, strlen($_SERVER['DOCUMENT_ROOT'])) == $_SERVER['DOCUMENT_ROOT']
      AND file_exists($alt_config)) {
    // found in a higher directory within DOCUMENT_ROOT
    require_once $alt_config;

} else {
    // not found, so this should error
    require_once 'config.inc';
} // if
unset($alt_config);

// look for an optional INCLUDE file for the current subsystem
$attempt = array();
if (!empty($GLOBALS['project_code'])) {
	$attempt[] = "./include.subsystem.{$GLOBALS['project_code']}.inc";
} // if
$attempt[] = './include.subsystem.inc';
$attempt[] = './include.subsystem.inc.default';
foreach ($attempt as $fn) {
	if (file_exists($fn)) {
		require($fn);
		break;
	} // if
} // foreach
unset($attempt, $fn);

// modify INCLUDE_PATH for standard subsystems
$include_path = ini_get('include_path');
if (is_dir('./transix/menu')) {
    $include_path .= PATH_SEPARATOR .'./transix/menu';
    $include_path .= PATH_SEPARATOR .'./transix/audit';
    $include_path .= PATH_SEPARATOR .'./transix/workflow';

} elseif (is_dir('../radicore/menu')) {
    $include_path .= PATH_SEPARATOR .'../radicore/menu';
    $include_path .= PATH_SEPARATOR .'../radicore/audit';
    $include_path .= PATH_SEPARATOR .'../radicore/workflow';

} elseif (is_dir('../menu')) {
    $include_path .= PATH_SEPARATOR .'../menu';
    $include_path .= PATH_SEPARATOR .'../audit';
    $include_path .= PATH_SEPARATOR .'../workflow';

} elseif (ini_get('open_basedir') == false AND is_dir('../../radicore/menu')) {
    $include_path .= PATH_SEPARATOR .'../../radicore/menu';
    $include_path .= PATH_SEPARATOR .'../../radicore/audit';
    $include_path .= PATH_SEPARATOR .'../../radicore/workflow';
} // if
ini_set('include_path', $include_path);

unset($include_path);

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
