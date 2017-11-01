<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
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

$errors = array();

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
        $errors = $fileobject->getErrors();
    } // if
    // get data from this instance
    $fieldarray = $fileobject->getFieldArray();
    // redo any configuration changes
    $fieldarray = $fileobject->getExtraData($fieldarray);
} else {
    $fileobject = new $table_id;
    // indicate that this object was started from a page controller
    $fileobject->initiated_from_controller = true;
    if (isset($sql_search_table)) {
        $fileobject->sql_search_table = $sql_search_table;
    } else {
        $fileobject->sql_search_table = 'mnu_file';
    } // if
    // do not create hyperlinks for column labels
    //$fileobject->xsl_params['nosort'] = 'y';
    // do not display the 'show nn' hyperlinks
    $fileobject->xsl_params['noshow'] = 'y';
    if (isset($task_orderby)) {
        $fileobject->setDefaultOrderby($task_orderby);
    } // if
    // perform any initialisation
    $fileobject->search = null;
    $where = $fileobject->initialise($where, $selection);
    if (!isset($search)) $search = null;
    $fileobject->initialiseFilePicker($where, $search);
    if ($fileobject->errors) {
    	scriptPrevious($fileobject->getErrors());
    } // if
} // if

if (!empty($selection)) {
    if (!empty($return_from) AND $return_action == 'choose' AND !empty($return_files)) {
        if (is_True($fileobject->return_uploaded_file)) {
            // send uploaded file back to the previous script
            $prev_script = getPreviousScript();
            $prev_task   = getPreviousTask($prev_script);
            $_SESSION['pages'][$prev_script][$prev_task]['selection'] = $selection;
            scriptPrevious(null, null, 'choose');
        } // if
    } // if
} // if

if (isset($_GET['select'])) {
    // send selection back to the previous script
    $prev_script = getPreviousScript();
    $prev_task   = getPreviousTask($prev_script);
    if (!empty($fileobject->picker_subdir)) {
    	$filename = $fileobject->picker_subdir.'/'.$_GET['select'];
    } else {
        $filename = $_GET['select'];
    } // if
    // set all directory separators to '/' as '\' is used as an escape character
    $filename = str_replace('\\', '/', $filename);
    // tell the fileobject that something has been selected
    $filename = $fileobject->filePickerSelect($filename);
    $_SESSION['pages'][$prev_script][$prev_task]['selection'] = $filename;
    scriptPrevious(null, null, 'choose');
} // if

// there is a separate cache file for each directory
$cache_name = 'filepicker1_'.md5($fileobject->picker_subdir).'_'.session_id().'.dat';
if (!empty($fileobject->cache_dir)) {
    //$cache = $fileobject->cache_dir.'/filepicker1_'.session_id().'.dat';
    $cache = $fileobject->cache_dir.'/'.$cache_name;
} else {
    //$cache = ini_get('session.save_path').'/filepicker1_'.session_id().'.dat';
    $cache = ini_get('session.save_path').'/'.$cache_name;
} // if
if (file_exists($cache)) {
    // recover file data from cache
    $file_list = unserialize(file_get_contents($cache));
    if (is_array($file_list)) {
        foreach ($file_list as $ix => $file_data) {
            $filename[$ix] = $file_data['file'];
            $filedate[$ix] = $file_data['date'];
            $filesize[$ix] = $file_data['size'];
        } // foreach
    } // if
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
    $null = $fileobject->reset($where);
    $file_list = null;  // rebuild list of files
    $fileobject->search = null;
} // if

$subdir   = $fileobject->picker_subdir;
$messages[] = getLanguageText('sys0187', $subdir);  // CURRENT DIRECTORY: ???
$filemask = $fileobject->picker_filetypes;

$fileobject->xsl_params['file_directory'] = $subdir;
if (!empty($fileobject->image_width)) {
	$fileobject->xsl_params['image_width'] = $fileobject->image_width;
} // if
if (!empty($fileobject->image_height)) {
	$fileobject->xsl_params['image_height'] = $fileobject->image_height;
} // if

$pattern = null;
if (!empty($quicksearch)) {
    $fileobject->setSqlQuickSearch($quicksearch, true);
} elseif (!empty($search)) {
    $fileobject->setSqlSearch($search, true);
} // if
$search_array = where2array($fileobject->sql_search);
if (!empty($search_array) AND !empty($search_array['filename'])) {
    $pattern = $search_array['filename'];
} // if
if (!empty($pattern)) {
    $fileobject->search = $pattern;  // store new pattern
} else {
    $pattern = $fileobject->search;  // use current pattern
} // if
if (!empty($pattern)) {
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

	$fileobject->search = $pattern;
    if (!empty($file_list) AND is_array($file_list)) {
        foreach ($file_list as $ix => $file_data) {
            if (!preg_match('/'.$pattern.'/i', $file_data['file'])) {
                unset($file_list[$ix]);
                unset($filename[$ix]);
                unset($filedate[$ix]);
                unset($filesize[$ix]);
            } // if
        } // foreach
    } // if
} elseif (!empty($fileobject->search)) {
    $pattern = $fileobject->search;
} // if

if (empty($file_list)) {
    $this_dir = @opendir($subdir);
    $file_list = array();
    $rownum    = 0;

    // these arrays are used for sorting
    $filename = array();
    $filedate = array();
    $filesize = array();

    if (is_resource($this_dir)) {
        while (false !== ($file = readdir($this_dir))) {
            if ($file == '.' OR $file == '..') {
                // ignore
            } elseif (preg_match('/^(directory)$/i', $filemask)) {
                // show directories instead of files
                if (is_dir($subdir.DIRECTORY_SEPARATOR.$file)) {
                    if (!empty($pattern)) {
                        if (preg_match('/'.$pattern.'/i', $file)) {
                            $file_list[$rownum]['file_name'] = $file;
                            $rownum++;
                        } // if
                    } else {
                        $file_list[$rownum]['file_name'] = $file;
                        $rownum++;
                    } // if
                } // if
            } elseif (preg_match('/'.$filemask.'/i', $file, $regs)) {
                // only files of right type are appended to array
                if (!empty($pattern)) {
                    if (preg_match('/'.$pattern.'/i', $file)) {
            	        $file_list[$rownum]['file_name'] = $file;  // display filename without the directory name
                    } // if
                } else {
                    $file_list[$rownum]['file_name'] = $file;  // display filename without the directory name
                } // if
                if (array_key_exists($rownum, $file_list)) {
                    $file_list[$rownum]['file_date'] = date('Y-m-d H:i:s', filemtime("$subdir/$file"));
                    $file_list[$rownum]['file_size'] = filesize("$subdir/$file");
                    // set up arrays for sorting
                    $filename[$rownum] = strtolower($file);
                    $filedate[$rownum] = $file_list[$rownum]['file_date'];
                    $filesize[$rownum] = $file_list[$rownum]['file_size'];
                    $rownum++;
                } // if
            } // if
        } // endwhile

        closedir($this_dir);

        if (count($file_list) > 2000) {
            // save this data in a cache file so that it can be recovered
            // (this is too big to go into the session data)
            if ($fh = fopen($cache, 'w')) {
                $res = fwrite($fh, serialize($file_list));
                fclose($fh);
            } else {
                // "cannot write to file X"
                $messages[] = getLanguageText('sys0055', $cache);
            } // if
        } // if
    } // if
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
    $fileobject->prev_sql_orderby = $fileobject->sql_orderby;
	$fileobject->setOrderBy($_GET['orderby'], $fileobject->sql_orderby_seq);
} // if
$orderby = $fileobject->getOrderBy();
if (!preg_match('/(file_name|file_size|file_date)/i', $orderby)) {
	$orderby = 'file_name';
	$fileobject->setOrderBy($orderby, $fileobject->sql_orderby_seq, false);
} // if
$fileobject->sql_orderby = $orderby;
if (isset($_GET['refresh'])) {
    // fired by a refresh, so do not toggle the sort sequence
    $orderby_seq = $fileobject->sql_orderby_seq;
} else {
    $orderby_seq = $fileobject->getOrderBySeq($orderby, $fileobject->sql_orderby_seq);
} // if

if (preg_match('/^(directory)$/i', $filemask)) {
    // sorting is turned off for directories
} else {
        // set sequence to be used by array_multisort
    if (empty($orderby_seq) OR $orderby_seq == 'asc') {
        $multisort_seq = SORT_ASC;
    } else {
        $multisort_seq = SORT_DESC;
    } // if

    if ($orderby == 'file_size') {
        array_multisort($filesize, $multisort_seq, $file_list);
    } elseif ($orderby == 'file_date') {
        array_multisort($filedate, $multisort_seq, $file_list);
    } else {  // $orderby == 'file_name'
        array_multisort($filename, $multisort_seq, $file_list);
    } // if
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

if (isset($_GET['action'])) {
    $fieldarray = $fileobject->setAction($_GET['action']);
} // if

$pagination['main']['numrows']  = $num_rows;
if ($last_page == 0) {
	$curr_page = 0;
} // if
$pagination['main']['curpage']  = $curr_page;
$pagination['main']['lastpage'] = $last_page;

$fileobject->setFieldArray($file_list);  // save data for next iteration
$script_vars['fileobject'] = serialize($fileobject);
$script_vars = updateScriptVars ($script_vars);

$fileobject->setFieldArray($file_list);  // replace data so that it can be displayed

// build list of objects for output to XML data
$xml_objects[]['root'] = &$fileobject;

// build XML document and perform XSL transformation
$view = new radicore_view($screen_structure);
$html = $view->buildXML($xml_objects, $errors, $messages);
echo $html;
exit;

?>
