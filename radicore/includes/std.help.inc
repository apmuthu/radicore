<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2017 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// Display help text for the specified task.

// Each page has three parts:
// header - contents of file 'help-header.txt'
// body - from database table 'help-text' for the given task_id
// footer - contents of file 'help-footer.txt'

require_once 'include.general.inc';

$mode = 'read'; // identify mode for XSL file

initSession();  // load session variables

if (isset($_GET['taskid'])) {
    $task_id = $_GET['taskid'];
} else {
    $task_id = 'unknown';
} // if

if (!isset($root)) {
    // not set, so use default value
    $root = 'HTTP://' . $_SERVER['HTTP_HOST'];
} // if

if (isset($_SESSION['user_language'])) {
	$lang = $_SESSION['user_language'];
} else {
    $lang = 'en';
} // if
$GLOBALS['party_language'] = strtoupper($lang);

require_once "classes/mnu_task.class.inc";
$taskOBJ = new mnu_task;
$data = $taskOBJ->getData("task_id='{$task_id}'");
if (!empty($data)) {
    $data = $data[0];
    $subsys_id = strtolower($data['subsys_id']);
    $task_name = $data['task_name'];
} else {
    $subsys_id = 'menu';
    $task_name = $task_id;
} // if

require_once "classes/help_text.class.inc";
$helpOBJ = new help_text;

$data = $helpOBJ->getData("task_id='{$task_id}'");
if (!empty($data)) {
    $data = $data[0];
    $help_text = $data['help_text'];
    if (preg_match('/^\[copy:[ ]*\w.+\]$/i', $help_text, $regs)) {
        // text contains nothing but '[copy: <task_id>]'
        if (preg_match('/(?<=\[copy:).+(?=])/i', $help_text, $regs)) {
            // extract '<task_id>' and retrieve its text instead
            $task_id = trim($regs[0]);
            $data = $helpOBJ->getData("task_id='{$task_id}'");
            if (!empty($data)) {
                $data = $data[0];
                $help_text = $data['help_text'];
            } // if
        } // if
    } // if
} else {
    // look for a file in the 'help' directory
    $directory = "../help";
    $filename = $task_id.'.html';
    // look for this file in one of the language sub-directories
    $fname = getLanguageFile($filename, $directory, true);
    if (!empty($fname)) {
        // file found, so display it and stop
        header('Location: '.$fname);
        exit;
    } // if
} // if

if (empty($help_text)) {
    $help_text = getLanguageText('sys0090', 'help_text'); // Nothing retrieved from database table 'x'
} // if

$title = getLanguageText('sys0099', $task_id); // "Help text for '$help_id'"

$search_array  = array('#\\\r\\\n(?!<)#u', '#\\\n(?!<)#u', '#\n(?!<)#u', '/%root%/u', '/%lang%/u');
$replace_array = array("<br />",           "<br />",       "<br />",     $root,       $lang);

// perform replacement in $help_text
$help_text = preg_replace($search_array, $replace_array, $help_text);

// perform replacement in optional header and footer
$dir = "../$subsys_id/text";
$header_fn = getLanguageFile('help-header.txt', $dir, true);
if ($header_fn) {
    $header = preg_replace($search_array, $replace_array, file_get_contents($header_fn));
} else {
    $header = '';
} // if

$footer_fn = getLanguageFile('help-footer.txt', $dir, true);
if ($footer_fn) {
    $footer = preg_replace($search_array, $replace_array, file_get_contents($footer_fn));
} else {
    $footer = '';
} // if

echo "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Strict//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd'>\n";
echo "<html xmlns='http://www.w3.org/1999/xhtml' xml:lang='$lang' lang='$lang'>\n";
echo "<head>\n";
echo "  <title>$title</title>\n";
echo "  <link rel='stylesheet' type='text/css' href='help.css' />\n";
echo "  <meta http-equiv='Content-type' content='text/html; charset=UTF-8' />\n";
echo "</head>\n";
echo "<body>\n";
echo "$header\n";
echo "<div class='body'>\n";
echo "<h1>$title</h1>\n";
echo "<h2>$task_name</h2>\n";
echo $help_text . "\n";
echo "</div>\n";
echo "$footer\n";
echo "</body>\n";
echo "</html>\n";

exit;

?>
