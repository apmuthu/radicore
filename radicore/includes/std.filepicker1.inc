<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2007 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.filepicker1.inc

// type = filepicker1

// This will list files in a directory and allow the user to choose one

require_once 'include.general.inc';

// identify mode for XSL file
$mode = 'read';

// load session variables
initSession();

// load session variables
if (isset($_POST['quit'])) {
    // the 'quit' button has been pressed, so ...
    // clear this script from session details and return to previous page
    scriptPrevious(getLanguageText('sys0087')); // 'Nothing selected from filepicker screen.'
} // if

if (isset($_POST['choosenull'])) {
    // send NULL selection back to the previous script
    $prev_script = getPreviousScript();
    $prev_task   = getPreviousTask($prev_script);
    $_SESSION[$prev_script][$prev_task]['selection'] = '';
    scriptPrevious(null, null, 'choose');
} // if

if (!empty($_POST)) {
    // look for an action which is another script
    $errors = childForm($_POST, null, $where);
} // if

// define action buttons
$act_buttons['quit'] = 'cancel';
$act_buttons['choosenull'] = 'choosenull';

if (isset($_GET['select'])) {
    // send selection back to the previous script
    $prev_script = getPreviousScript();
    $prev_task   = getPreviousTask($prev_script);
    $_SESSION[$prev_script][$prev_task]['selection'] = $_GET['select'];
    scriptPrevious(null, null, 'choose');
} // if

// create a class instance for the main database table
require_once "classes/$table_id.class.inc";
if (isset($script_vars['fileobject'])) {
    // use data from previous instance for this script
    $fileobject = unserialize($script_vars['fileobject']);
} else {
    $fileobject = new $table_id;
    // do not create hyperlinks for column labels
    $fileobject->xsl_params['nosort'] = 'y';
    // do not display the 'show nn' hyperlinks
    $fileobject->xsl_params['noshow'] = 'y';
    // perform any initialisation
    $fileobject->initialiseFilePicker();
    if ($fileobject->errors) {
    	scriptPrevious($fileobject->errors);
    } // if
} // if

$subdir   = $fileobject->picker_subdir;
$filemask = $fileobject->picker_filetypes;
$errors = array();

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

// copy data into main object
$fileobject->setFieldArray($file_list);

// build list of objects for output to XML data
$xml_objects[]['root'] = &$fileobject;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);
exit;

?>
