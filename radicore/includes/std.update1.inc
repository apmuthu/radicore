<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2015 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.update1.inc

// type = update1

// This will allow a single database row to be displayed and updated.
// The primary key of the row is passed in $where from the previous screen.
// If multiple entries were selected in the prevous screen then a scrollbar
// will be made available for the user to scroll between these entries.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'update';

// load session variables
initSession();

//if (!empty($selection) AND !isset($return_from)) {
//	// $selection takes precedence over $where
//    $where     = $selection;
//    $selection = null;
//} // if

if (isset($_POST['quit'])) {
    // cancel this screen, return to previous screen
    scriptPrevious(null, null, 'quit');
} // if

// define action buttons
$act_buttons['submitBtn']  = 'submit';  // do not use name 'submit' as this conflicts with javascript 'submit()' function.
//$act_buttons['submitstay'] = 'submitstay';  // this is usually hidden
$act_buttons['submitnext'] = 'submitnext';
$act_buttons['copy']       = 'copy';
$act_buttons['quit']       = 'cancel';

// create a class instance for the MAIN database table
require_once "classes/$table_id.class.inc";
if (isset($script_vars['dbobject'])) {
    // use data from previous instance for this script
    $dbobject = unserialize($script_vars['dbobject']);
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $dbobject->restart($return_from, $return_action, $return_string, $return_files);
    } // if
    // get data from previous instance
    $fieldarray = $dbobject->getFieldArray();
    // redo any configuration changes
    $fieldarray = $dbobject->getExtraData($fieldarray);
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
    $messages = array_merge($messages, $dbobject->getMessages());
    if ($dbobject->errors) {
        scriptPrevious($dbobject->getErrors(), $messages, 'fail');
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

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    // check if we are returning from a child form
    if (!empty($return_from) AND (!empty($popup_object) OR isset($selection))) {
        // merge previous saved variables with selection from popup form
        $fieldarray = $dbobject->popupReturn($fieldarray, basename($return_from), $selection, null, $return_files);
        if ($dbobject->errors) {
            $errors = $dbobject->getErrors();
        } // if
    } else {
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

        // get data from the database
        if (isset($no_getdata) AND is_True($no_getdata)) {
            // returning from a script that does not want any pending changes to be lost
        } else {
            $fieldarray = $dbobject->getData($where);
            if (!empty($fieldarray)) {
                $fieldarray = $fieldarray[0];
            } // if
            $fieldarray = $dbobject->getExtraData($fieldarray);
        } // if
        $fieldarray = $dbobject->validateUpdate($fieldarray, false, true);  // perform SECONDARY validation only
        if ($dbobject->errors) {
            if ($dbobject->numrows > 1) {
                // multiple rows, so display error message with this screen
                $errors = $dbobject->getErrors();
            } else {
                // single row, so return to previous script before displaying error message
                $messages = array_merge($messages, $dbobject->getMessages());
                scriptprevious($dbobject->getErrors(), $messages, 'fail');
            } // if
        } else {
            // no errors, so turn off the 'noedit' switch
            unset($dbobject->xsl_params['main_noedit']);
        } // if
        if ($dbobject->getNumRows() < 1) {
            scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
        } // if

        // set variables to be included in XML output
        $scrolling[$dbobject->getClassName()]['curitem']  = $dbobject->getPageNo();
        $scrolling[$dbobject->getClassName()]['lastitem'] = $dbobject->getLastPage();
        $scrolling[$dbobject->getClassName()]['where']    = $where;

        // rebuild selection criteria using primary key of 1st occurrence
        $where = array2where($fieldarray, $dbobject->getPkeyNames(), $dbobject);

        if (!empty($errors) AND empty($return_from)) {
            // switch the whole zone into 'noedit' mode
            $dbobject->xsl_params['main_noedit'] = 'y';
            unset($act_buttons['submitBtn']);
            unset($act_buttons['submitnext']);
        } // if
    } // if
} // if

if (!empty($_POST)) {
    //if (isset($_POST['copy'])) {
    //    // save current data so that it be be PASTed later
    //    $messages = copyForm($_POST, $dbobject);

    //} elseif (isset($_POST['paste'])) {
    if (isset($_POST['paste'])) {
        // merge initial data with previously saved data
        $fieldarray = pasteData($dbobject, $fieldarray, $_SESSION['data'][$dbobject->tablename]);
        // get any additional data
        $fieldarray = $dbobject->getExtraData($fieldarray);

    } else {
        // identify if one of the 'submit' buttons has been pressed
        $submit_button = check_submit_button($act_buttons, $_POST);
        $task_button   = check_task_button($_POST);
        $custom_button = check_custom_button($_POST);
        if ($submit_button OR $task_button OR $custom_button OR isset($_POST['copy'])) {
            // merge original data with POSTed data (so that fields which were displayed
            // but not POSTed are sent back if any errors are displayed).
            $fieldarray = array_update_associative($fieldarray, $_POST, $dbobject->fieldspec);
            // ensure that changes are stored inside relevant object
            $dbobject->setFieldArray($fieldarray);

        } else {
            // deal with a javascript 'submit()'.
            $fieldarray = $dbobject->updateFieldArray($fieldarray, $_POST);
            if ($dbobject->errors) {
                $errors = $dbobject->getErrors();
            } // if
        } // if

        if (isset($_POST['copy'])) {
            // save current data so that it be be PASTed later
            $messages = copyForm($_POST, $dbobject);

        } elseif (empty($errors) AND !empty($task_button)) {
            // look for a navigation or popup button which jumps to another script
            $child_errors = childForm($_POST, array('dbobject' => $dbobject), $task_button);
            if (is_array($child_errors)) {
                $errors[$dbobject->getClassName()] = $child_errors;
            } // if

        } elseif (empty($errors) AND !empty($custom_button)) {
            // a custom button was pressed
            list($custom_btn, $btn_row, $btn_zone) = $custom_button;
            // save current data in case a custom button jumps to another script
            $script_vars['dbobject'] = serialize($dbobject);
            $fieldarray = $dbobject->customButton($fieldarray, $custom_btn, $_POST);
            if ($dbobject->errors) {
                $errors[$dbobject->getClassName()] = $dbobject->getErrors();
            } // if
            unset($custom_button);

        } elseif (empty($errors) AND !empty($submit_button)) {
            $dbobject->startTransaction();
            // update this data in the database
            $fieldarray = $dbobject->updateRecord($fieldarray);
            $messages = array_merge($messages, $dbobject->getMessages());
            if ($dbobject->errors) {
                $errors = $dbobject->getErrors();
            } // if
            if (empty($errors)) {
                // "N records were updated in XXXX"
                $messages[] = getLanguageText('sys0006', $dbobject->numrows, strtoupper($dbobject->tablename));
                // ensure that object contains all messages in case workflow jumps to another task
                $dbobject->messages = $messages;
                $errors = $dbobject->commit();
            } // if
            if (!empty($errors)) {
                $dbobject->rollback();
            } else {
                //if ($dbobject->numrows > 0) {
                //    $messages[] = getLanguageText('sys0092'); // 'Record updated OK'
                //} else {
                //    $messages[] = getLanguageText('sys0209'); // 'Nothing has changed'
                //} // if
                if (isset($_POST['submitnext'])) {
                    $curitem  = $scrolling[$dbobject->getClassName()]['curitem'];
                    $lastitem = $scrolling[$dbobject->getClassName()]['lastitem'];
                    if ($curitem < $lastitem) {
                        // skip to the next item
                        $curitem++;
                        $scrolling[$dbobject->getClassName()]['curitem'] = $curitem;
                        $dbobject->setPageNo($curitem);
                    } else {
                        // no more items, so return to previous screen
                        scriptPrevious($errors, $messages, 'update', $dbobject->getInstruction());
                    } // if
                } elseif (isset($_POST['submitBtn'])) {
                    if ($scrolling[$dbobject->getClassName()]['lastitem'] <= 1) {
                        // update was OK, no more items, so return to previous screen
                        scriptPrevious($errors, $messages, 'update', $dbobject->getInstruction());
                    } // if
                } // if
                // treat as if 'submitstay' button was pressed and stay on current record
                // re-read database in case any other values have been changed
                $where = $scrolling[$dbobject->getClassName()]['where'];
                $fieldarray = $dbobject->getData($where);
                if ($dbobject->getNumRows() < 1) {
                    scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
                } // if
                $fieldarray = $dbobject->getExtraData($fieldarray);
                // reset 'lastitem' in scroll array
                $scrolling[$dbobject->getClassName()]['lastitem'] = $dbobject->getLastPage();
                $script_vars['scrolling'] = $scrolling;
                // reduce $where to current row only for passing to a child form
                $where = array2where($fieldarray, $dbobject->getPkeyNames(), $dbobject);
            } // if
        } // if
    } // if
} // if

if (isset($_SESSION['data'][$dbobject->tablename])) {
    // saved data exists, so allow a PASTE button
    $prepend = array('paste' => 'paste');
    $act_buttons = array_merge($prepend, $act_buttons);
} // if

if (!empty($dbobject->messages)) {
    $messages = array_merge($messages, $dbobject->getMessages());
    $messages = array_unique($messages);
} // if

// save these variables for later in the same session
$script_vars['where']     = $where;
$script_vars['dbobject']  = serialize($dbobject);
$script_vars['scrolling'] = $scrolling;
$script_vars = updateScriptVars ($script_vars);

$dbobject->fieldarray = $fieldarray;  // replace data lost during serialization

if ($_SERVER['REQUEST_METHOD'] == 'POST' AND empty($errors) AND $submit_button) {
    // repeat current task with GET instead of POST
    $_SESSION['no_getdata'] = true;
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
