<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2008 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// Display help text for the specified task.

// Each page has three parts:
// header - contents of file 'help-header.txt'
// body - from database table 'help-text' for the given task_id
// footer - contents of file 'help-footer.txt'

require_once 'include.general.inc';

if (isset($_GET['taskid'])) {
    $help_id = $_GET['taskid'];
} else {
    $help_id = 'unknown';
} // if

// identify mode for XSL file
$mode = 'read';

// load session variables
initSession();

$help_desc = getLanguageText($help_id);

$title = getLanguageText('sys0099', $help_id, $help_desc); // "Help text for '$help_id'"

if (!isset($root)) {
    // not set, so use default value
    $root = 'HTTP://' . $_SERVER['HTTP_HOST'];
} // if

if (isset($_SESSION['user_language'])) {
	$lang = $_SESSION['user_language'];
} else {
    $lang = NULL;
} // if

$errors = array();

// get subdirectory which matches user's language code
$subdir = getLanguageSubDir ('./help');

$help = "$subdir/$help_id.help.txt";  // look in subirectory for this file name
if (file_exists($help)) {
    $help_text = file_get_contents($help);
} else {
    $help_text = getLanguageText('sys0056', $help); // 'File $help cannot be found'
} // if

$search_array  = array("\n"    , "%root%", "%lang%");
$replace_array = array("<br />", $root   , $lang);

// perform replacement in $help_text
$help_text = str_replace($search_array, $replace_array, $help_text);

$search_array  = array(">\n"    , "%root%", "%lang%");
$replace_array = array("<br />", $root   , $lang);

// perform replacement in optional header and footer
$header = str_replace($search_array, $replace_array, file_get_contents('help-header.txt'));
$footer = str_replace($search_array, $replace_array, file_get_contents('help-footer.txt'));

echo "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN' 'http://www.w3.org/TR/html4/loose.dtd'>\n";
echo "<html xml:lang='$lang' lang='$lang'>\n";
echo "<head>\n";
echo "  <title>$title</title>\n";
echo "  <link rel='stylesheet' type='text/css' href='help.css' />\n";
echo "</head>\n";
echo "<body>\n";
echo "$header\n";
echo "<div class='body'>\n";
echo "<h1>$title</h1>\n";
echo $help_text . "\n";
echo "</div>\n";
echo "$footer\n";
echo "</body>\n";
echo "</html>\n";

exit;

?>
