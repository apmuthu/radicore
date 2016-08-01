<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.delete1.inc

// type = delete1

// Delete a single selected occurrence from the database.
// The primary key of the row is passed in $where from the previous screen.
// If multiple entries were selected in the prevous screen then a scrollbar
// will be made available for the user to scroll between these entries.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'delete';

// load session variables
initSession();

//if (!empty($selection) AND !isset($return_from)) {
//    // $selection takes precedence over $where
//    $where     = $selection;
//    $selection = null;
//} // if

if (isset($_POST['quit'])) {
    // cancel this screen, return to previous screen
    scriptPrevious(null, null, 'quit');
} // if

// define action buttons
$act_buttons['submitBtn'] = 'submit';  // do not use name 'submit' as this conflicts with javascript 'submit()' function.
$act_buttons['copy']      = 'copy';
$act_buttons['quit']      = 'cancel';

// create a class instance for the main database table
require_once "classes/$table_id.class.inc";
if (isset($script_vars['dbobject'])) {
    // use data from previous instance of this script
    $dbobject = unserialize($script_vars['dbobject']);
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $dbobject->restart($return_from, $return_action);
    } // if
    // get data from previous instance
    $fieldarray = $dbobject->getFieldArray();
} else {
    // create new instance for initial activation of this script
    $dbobject = new $table_id;
    // indicate that this object was started from a page controller
    $dbobject->initiated_from_controller = true;
    $dbobject->sql_select  = &$sql_select;
    $dbobject->sql_from    = &$sql_from;
    $dbobject->sql_where   = &$sql_where;
    $dbobject->sql_groupby = &$sql_groupby;
    $dbobject->sql_having  = &$sql_having;
    // scroll through one item at a time
    $dbobject->setRowsPerPage(1);
    // check that primary key is complete
    $dbobject->checkPrimaryKey = true;
    // perform any initialisation
    $where = $dbobject->initialise($where, $selection);
    if ($dbobject->errors) {
        scriptPrevious($dbobject->getErrors());
    } // if
    // set sort order (if defined)
    if (!empty($orderby)) {
        $string = validateSortItem('main', $orderby, $dbobject, $screen_structure);
        $dbobject->setOrderBy($string);
        if (!empty($orderby_seq)) {
            $dbobject->setOrderBySeq($orderby_seq);
        } // if
    } // if
} // if

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_POST['copy'])) {
        $messages = copyForm($_POST, $dbobject);

    } else {
        // identify if one of the 'submit' buttons has been pressed
        $submit_button = check_submit_button($act_buttons, $_POST);
        $task_button   = check_task_button($_POST);
        if (!empty($task_button)) {
            // look for a navigation or popup button which jumps to another script
            $child_errors = childForm($_POST, array('dbobject' => $dbobject), $task_button);
            if (is_array($child_errors)) {
                $errors[$dbobject->getClassName()] = $child_errors;
            } // if

        } elseif (!empty($submit_button) AND empty($errors)) {
            // the 'delete' button has been pressed
            $dbobject->startTransaction();
            // delete this record from the database
            $fieldarray = $dbobject->deleteRecord($fieldarray);
            // retrieve errors from database object
            $errors = $dbobject->getErrors();
            if (empty($errors)) {
                $messages[] = getLanguageText('sys0004', 1, strtoupper($dbobject->tablename));
                $errors = $dbobject->commit();
            } // if
            if (empty($errors)) {
                //$messages[] = getLanguageText('sys0004', 1, strtoupper($dbobject->tablename));
                if ($scrolling[$dbobject->getClassName()]['lastitem'] == 1) {
                    // last item has been deleted, so return to previous screen
                    scriptPrevious(null, $messages, 'delete', $dbobject->getInstruction());
                } // if
            } else {
                $dbobject->rollback();
            } // if
        } // if
    } // if
} // if

if (isset($scrolling)) {
    // retrieve values from scrolling array
    $where = $scrolling[$dbobject->getClassName()]['where'];
    if (isset($_GET['scrolling']) AND $_GET['scrolling'] == $dbobject->getClassName()) {
        // set index number of item to be read from current $where list
        $dbobject->setPageNo($_GET['item']);
    } else {
        $dbobject->setPageNo($scrolling[$dbobject->getClassName()]['curitem']);
    } // if
} // if
if (empty($where)) {
    scriptPrevious(getLanguageText('sys0081')); // 'Nothing has been selected yet.'
} // if

if (empty($errors)) {
    // get data from the database
    $fieldarray = $dbobject->getData($where);
    if ($dbobject->errors) {
        $errors = $dbobject->getErrors();
        if ($dbobject->numrows > 1) {
            // multiple rows, so display error message with this screen
        	unset($act_buttons['submitBtn']);
        } else {
            // single row, so return to previous script before displaying error message
            $messages = array_merge($messages, $dbobject->getMessages());
            scriptprevious($errors, $messages, 'fail');
        } // if
    } // if
    if ($dbobject->getNumRows() < 1) {
        scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
    } // if
} // if

// set scrolling variables to be included in XML output
$scrolling[$dbobject->getClassName()]['curitem']  = $dbobject->getPageNo();
$scrolling[$dbobject->getClassName()]['lastitem'] = $dbobject->getLastPage();
$scrolling[$dbobject->getClassName()]['where']    = $where;

// if ($_SERVER['REQUEST_METHOD'] == 'GET') {
//if (empty($errors)) {
	// get any extra data and merge with $fieldarray
    $fieldarray = $dbobject->getExtraData($fieldarray);
    if ($dbobject->errors) {
    	$errors = $dbobject->getErrors();
    } // if
//} // if

if (empty($errors)) {
    // check that this record can be deleted
	$fieldarray = $dbobject->validateDelete($fieldarray);
    if ($dbobject->errors) {
    	$errors = $dbobject->getErrors();
    } // if
} // if

if (!empty($dbobject->messages)) {
    $messages = array_merge($messages, $dbobject->getMessages());
} // if

if ($errors) {
    // remove the 'submit' button
    unset($act_buttons['submitBtn']);
} else {
    $messages[] = getLanguageText('sys0086'); // 'Press SUBMIT to confirm deletion.'
    $messages   = array_unique($messages);
} // if

// save these variables for later in the same session
$script_vars['where']     = $where;
$script_vars['scrolling'] = $scrolling;
$script_vars['dbobject']  = serialize($dbobject);
$script_vars = updateScriptVars ($script_vars);

$dbobject->fieldarray = $fieldarray;  // replace data lost during serialization

if ($_SERVER['REQUEST_METHOD'] == 'POST' AND empty($errors)) {
    // repeat current task with GET instead of POST
    scriptNext($GLOBALS['task_id'], $where);
} // if

if (!empty($errors)) {
    // all errors are associated with this table
    $errors2[$dbobject->getClassName()] = $errors;
    $errors = $errors2;
} // if

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbobject;

// build XML document and perform XSL transformation
$view = new radicore_view($screen_structure);
$html = $view->buildXML($xml_objects, $errors, $messages);
echo $html;
exit;

?>
