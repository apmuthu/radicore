<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.filepicker2.inc

// type = filepicker1

// This will list files in a remote directory and allow the user to choose one.
// This accesses the files via FTP

require_once 'include.general.inc';

// identify mode for XSL file
$mode = 'read';

// load session variables
initSession();

// load session variables
if (isset($_POST['quit'])) {
    // the 'quit' button has been pressed, so ...
    // clear this script from session details and return to previous page
    $prev_pattern = getPreviousPattern();
    if (preg_match('/^(menu|list)/i', $prev_pattern)) {
    	$message = null;
    } else {
        // 'Nothing selected from filepicker screen.'
        $message = getLanguageText('sys0087');
    } // if
    scriptPrevious($message, null,'quit');
} // if

if (isset($_POST['choosenull'])) {
    // send NULL selection back to the previous script
    $prev_script = getPreviousScript();
    $prev_task   = getPreviousTask($prev_script);
    $_SESSION['pages'][$prev_script][$prev_task]['selection'] = '';
    scriptPrevious(null, null, 'choose');
} // if

if (!empty($selection)) {
    if (!empty($return_from) AND $return_action == 'choose') {
    	// send uploaded file back to the previous script
        $prev_script = getPreviousScript();
        $prev_task   = getPreviousTask($prev_script);
        $_SESSION['pages'][$prev_script][$prev_task]['selection'] = $selection;
        scriptPrevious(null, null, 'choose');
    } else {
        // $selection takes precedence over $where
        $where     = $selection;
        $selection = null;
    } // if
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
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $fileobject->restart($return_from, $return_action, $return_string, $return_files);
    } // if
} else {
    $fileobject = new $table_id;
    // indicate that this object was started from a page controller
    $fileobject->initiated_from_controller = true;
    $fileobject->sql_search_table = &$sql_search_table;
    // do not create hyperlinks for column labels
    //$fileobject->xsl_params['nosort'] = 'y';
    // do not display the 'show nn' hyperlinks
    $fileobject->xsl_params['noshow'] = 'y';
    // perform any initialisation
    $where = $fileobject->initialise($where, $selection);
    if (!isset($search)) $search = null;
    $fileobject->initialiseFilePicker($where, $search);
    if ($fileobject->errors) {
    	scriptPrevious($fileobject->getErrors());
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
    // tell the fileobject that something has been selected
    $filename = $fileobject->filePickerSelect($filename);
    $_SESSION['pages'][$prev_script][$prev_task]['selection'] = $filename;
    scriptPrevious(null, null, 'choose');
} // if

if (!empty($_POST)) {
    $task_button = check_task_button($_POST);
    if (!empty($task_button)) {
        // look for an action which is another script
        $child_errors = childForm($_POST, array('dbobject' => &$fileobject), $task_button, $where);
        if (is_array($child_errors)) {
            $errors = array_merge($errors, $child_errors);
        } // if
    } // if
} // if

if (isset($_POST['reset'])) {
    // re-initialise all settings to start afresh
    $where = $fileobject->reset($where);
} // if

$ftp_server = $fileobject->ftp_server;
$subdir     = $fileobject->picker_subdir;
if (!empty($subdir)) {
    $messages[] = getLanguageText('sys0187', $ftp_server.'/'.$subdir);
} // if
$filemask = $fileobject->picker_filetypes;
if (!isset($errors)) $errors = array();

$fileobject->xsl_params['file_directory'] = $subdir;
if (!empty($fileobject->image_width)) {
	$fileobject->xsl_params['image_width'] = $fileobject->image_width;
} // if
if (!empty($fileobject->image_height)) {
	$fileobject->xsl_params['image_height'] = $fileobject->image_height;
} // if

if (!empty($search)) {
    $pattern = null;
    $search_array = where2array($search);
	if (!empty($search_array['filename'])) {
	    $pattern = $search_array['filename'];
	    if (substr_count($pattern, '%') > 1) {
	        // replace SQL 'any characters' with regex equivalent
		    $pattern = str_replace('%', '.*', $pattern);
	    } elseif (substr($pattern, -1, 1) == '%') {
	        // last character is SQL wild card, so set to 'begins with'
	    	$pattern = '^' .$pattern;
	    } elseif (substr($pattern, 0, 1) == '%') {
	        // first character is SQL wild card, so set to 'ends with'
	        $pattern = $pattern .'$';
	    } // if
		$pattern = str_replace('%', '', $pattern);
	} // if
	$fileobject->search = $pattern;
} elseif (!empty($fileobject->search)) {
    $pattern = $fileobject->search;
} // if

// connect to FTP server
$ftp_server    = $fileobject->ftp_server;
$ftp_user_name = $fileobject->ftp_user_name;
$ftp_user_pass = $fileobject->ftp_user_pass;
$conn_id = ftp_connect($ftp_server);
$login_result = ftp_login($conn_id, $ftp_user_name, $ftp_user_pass);
ftp_pasv($conn_id, true);
// check connection
if ((!$conn_id) OR (!$login_result)) {
    $errors[] = "Cannot connect to '$ftp_server' for user '$ftp_user_name'";
    scriptPrevious($errors);
} // if

if (!empty($subdir)) {
    if (!@ftp_chdir($conn_id, $subdir)) {
        $errors[] = "Remote directory '$subdir' does not exist";
        scriptPrevious($errors);
    } // if
} // if

//$this_dir = @opendir($subdir);
$file_list = array();
$rownum    = 0;

// these arrays are used for sorting
$filename = array();
$filedate = array();
$filesize = array();

$ix = 0;
if (is_resource($conn_id)) {
    $filearray = ftp_nlist($conn_id, '.');
    foreach ($filearray as $file) {
        if (preg_match('/(\.[a-zA-Z0-9]+)$/', $file)) {
            // this ends in '.xxx' so assume it is a file and not a directory
            if (preg_match('/'.$filemask.'/i', $file, $regs)) {
                $ix++;
                if (!empty($pattern)) {
                    if (preg_match('/'.$pattern.'/i', $file)) {
                        $file_list[$ix]['file'] = $file;  // display filename without the directory name
                    } // if
                } else {
                    $file_list[$ix]['file'] = $file;  // display filename without the directory name
                } // if
            } // if
            if (array_key_exists($ix, $file_list)) {
                $mdtm = ftp_mdtm($conn_id, $file);
                if ($mdtm != -1) {
                    $file_list[$ix]['date'] = date("Y-m-d H:i:s", $mdtm);
                } else {
                    $file_list[$ix]['date'] = '';
                } // if
                $file_list[$ix]['size'] = ftp_size($conn_id, $file);
                // set up arrays for sorting
                $filename[$ix] = strtolower($file);
                $filedate[$ix] = $file_list[$ix]['date'];
                $filesize[$ix] = $file_list[$ix]['size'];
            } // if
        } // if
    } // foreach
    ftp_close($conn_id);
} // if

if (count($file_list) == 0) {
    $messages[] = getLanguageText('sys0089'); // 'Nothing was found matching this profile'
    if (strtolower($return_action) == 'search') {
        if (isset($return_from)) {
            // go back to script which generated this profile
            scriptNext($return_from, $where);
        } // if
    } // if
} // if

if (isset($_GET['orderby'])) {
	$fileobject->setOrderBy($_GET['orderby'], $fileobject->sql_orderby_seq);
} // if
$orderby = $fileobject->getOrderBy();
if (!preg_match('/(file|size|date)/i', $orderby)) {
	$orderby = 'file';
	$fileobject->setOrderBy($orderby, $fileobject->sql_orderby_seq, false);
} // if
$fileobject->sql_orderby = $orderby;
if (isset($_GET['refresh'])) {
    // fired by a refresh, so do not toggle the sort sequence
    $orderby_seq = $fileobject->sql_orderby_seq;
} else {
    $orderby_seq = $fileobject->getOrderBySeq($orderby, $fileobject->sql_orderby_seq);
} // if
// set sequence to be used by array_multisort
if (empty($orderby_seq) OR $orderby_seq == 'asc') {
 	$multisort_seq = SORT_ASC;
} else {
    $multisort_seq = SORT_DESC;
} // if

if ($orderby == 'file') {
	array_multisort($filename, $multisort_seq, $file_list);
} elseif ($orderby == 'size') {
	array_multisort($filesize, $multisort_seq, $file_list);
} else {
    array_multisort($filedate, $multisort_seq, $file_list);
} // if

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

if (isset($_GET['action'])) {
    $fieldarray = $fileobject->setAction($_GET['action']);
} // if

$pagination['main']['numrows']  = $num_rows;
if ($last_page == 0) {
	$curr_page = 0;
} // if
$pagination['main']['curpage']  = $curr_page;
$pagination['main']['lastpage'] = $last_page;

$script_vars['fileobject'] = serialize($fileobject);
$script_vars = updateScriptVars ($script_vars);

$fileobject->fieldarray = $file_list;  // replace data lost during serialization

// build list of objects for output to XML data
$xml_objects[]['root'] = &$fileobject;

// build XML document and perform XSL transformation
$view = new radicore_view($screen_structure);
$view->buildXML($xml_objects, $errors, $messages);
exit;

?>
