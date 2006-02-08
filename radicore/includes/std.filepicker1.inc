<?php
// *****************************************************************************
// Copyright 2003-2006 by A J Marston <http://www.tonymarston.net>
// Licensed to Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.filepicker1.inc

// type = filepicker1

// This will list files in a directory and allow the user to choose one

require_once 'include.general.inc';

initSession();

// load session variables
if (isset($_POST['quit'])) {
    // the 'quit' button has been pressed, so ...
    // clear this script from session details and return to previous page
    scriptPrevious(getLanguageText('sys0087')); // 'Nothing selected from filepicker screen.'
} // if

if (!empty($_POST)) {
    // look for an action which is another script
    $errors = childForm($_POST, null, null, $where);
} // if

// define action buttons
$act_buttons['quit'] = 'cancel';

if (isset($_GET['select'])) {
    // send selection back to the previous script
    $prev_script = getPreviousScript();
    $prev_task   = getPreviousTask($prev_script);
    $_SESSION[$prev_script][$prev_task]['selection'] = $_GET['select'];
    scriptPrevious(null, null, 'choose');
} // if

$errors = array();

switch ($filetype) {
    case 'image':
        $filemask = "(\.gif|\.jpg|\.png|\.bmp)$";
        break;
    default:
        $errors[] = getLanguageText('sys0059', $filetype); // "Unknown filetype ($filetype)"
} // switch

$this_dir = @opendir($subdir);
$file_list = array();
while (false !== ($file = readdir($this_dir))) {
    // only files of right type are appended to array
    if (eregi($filemask, $file, $regs)) {
        $file_list[] = "$subdir/$file";
    } // if
} // endwhile

closedir($this_dir);
sort($file_list);

// copy data into a dummy object
require_once 'std.table.class.inc';
class File extends Default_Table {} ;
$fileobj = new File;
$fileobj->setFieldArray($file_list);

// build list of objects for output to XML data
$xml_objects[]['root'] = &$fileobj;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);
exit;

?>
