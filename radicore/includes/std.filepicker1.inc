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
    scriptPrevious(getLanguageText('sys0087'),null,'quit'); // 'Nothing selected from filepicker screen.'
} // if

if (isset($_POST['choosenull'])) {
    // send NULL selection back to the previous script
    $prev_script = getPreviousScript();
    $prev_task   = getPreviousTask($prev_script);
    $_SESSION[$prev_script][$prev_task]['selection'] = '';
    scriptPrevious(null, null, 'choose');
} // if

// define action buttons
$act_buttons['reset'] = 'reset';
$act_buttons['quit']  = 'cancel';
$act_buttons['choosenull'] = 'choosenull';

// create a class instance for the main database table
require_once "classes/$table_id.class.inc";
if (isset($script_vars['fileobject'])) {
    // use data from previous instance for this script
    $fileobject = unserialize($script_vars['fileobject']);
} else {
    $fileobject = new $table_id;
    // indicate that this object was started from a page controller
    $fileobject->initiated_from_controller = true;
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

if (isset($_GET['select'])) {
    // send selection back to the previous script
    $prev_script = getPreviousScript();
    $prev_task   = getPreviousTask($prev_script);
    if (!empty($fileobject->picker_subdir)) {
    	$filename = $fileobject->picker_subdir .'/' .$_GET['select'];
    } else {
        $filename = $_GET['select'];
    } // if
    $_SESSION[$prev_script][$prev_task]['selection'] = $filename;
    scriptPrevious(null, null, 'choose');
} // if

if (!empty($_POST)) {
    // look for an action which is another script
    $errors = childForm($_POST, array('fileobject' => &$fileobject), $where);
} // if

$subdir   = $fileobject->picker_subdir;
$filemask = $fileobject->picker_filetypes;
$errors = array();

$fileobject->xsl_params['image_directory'] = $subdir;
if (!empty($fileobject->image_width)) {
	$fileobject->xsl_params['image_width'] = $fileobject->image_width;
} // if
if (!empty($fileobject->image_height)) {
	$fileobject->xsl_params['image_height'] = $fileobject->image_height;
} // if

if (isset($_POST['reset'])) {
    // initialise all settings to start afresh
    $fileobject->reset($where);
    $fileobject->search = null;
} // if

if (!empty($search)) {
	$search_array = where2array($search);
	if (!empty($search_array['filename'])) {
	    // replace SQL 'any characters' with regex equivalent
		$search_array['filename'] = str_replace('%', '.*', $search_array['filename']);
	} // if
	$fileobject->search = $search_array['filename'];
} elseif (!empty($fileobject->search)) {
    $search_array['filename'] = $fileobject->search;
} // if

$this_dir = @opendir($subdir);
$file_list = array();
while (false !== ($file = readdir($this_dir))) {
    // only files of right type are appended to array
    if (eregi($filemask, $file, $regs)) {
        if (!empty($search_array['filename'])) {
            if (eregi($search_array['filename'], $file)) {
            	$file_list[] = $file;  // display filename without the directory name
            } // if
        } else {
            $file_list[] = $file;  // display filename without the directory name
        } // if
    } // if
} // endwhile

closedir($this_dir);
sort($file_list);

// set pagination data
$limit     = 100;
$num_rows  = count($file_list);
$last_page = ceil($num_rows / $limit);
if (isset($_GET['page'])) {
	$curr_page = abs($_GET['page']);
} // if
if (empty($curr_page) OR $curr_page < 1) {
	$curr_page = 1;
} // if
$offset = ($curr_page - 1) * $limit;

// copy data into object's $fieldarray so that it can be displayed
$file_list = array_slice($file_list, $offset, $limit);
$fileobject->setFieldArray($file_list);

$pagination['main']['numrows']  = $num_rows;
$pagination['main']['curpage']  = $curr_page;
$pagination['main']['lastpage'] = $last_page;

$script_vars['fileobject'] = serialize($fileobject);
$script_vars = updateScriptVars ($script_vars);

// build list of objects for output to XML data
$xml_objects[]['root'] = &$fileobject;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);
exit;

?>
