<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-201 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.multi1.inc

// type = multi1

// This will allow one (or more) database record(s) to be updated, or inserted if
// it/they do not currently exist.
// The primary key(s) of the selected record(s) are passed down in $where.
// NOTE: scrolling is done via the setScrollArray() and getScrollItem() methods.

// NOTE: the RESET button will drop current changes and reset the page to its
// original contents.
// The DELETE button will only appear if the current record exists.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'update';

// load session variables
initSession();

$original_where     = $where;
$original_selection = $selection;
if (!empty($selection) AND !isset($return_from)) {
	// $selection takes precedence over $where
    //$where     = $selection;
    //$selection = null;
} // if

if (isset($_POST['quit'])) {
    // cancel this screen, return to previous screen
    scriptPrevious(null, null, 'quit');
} // if

// define action buttons
$act_buttons['submitBtn']  = 'submit';  // do not use name 'submit' as this conflicts with javascript 'submit()' function.
$act_buttons['submitnext'] = 'submitnext';
$act_buttons['reset']      = 'reset';
$act_buttons['quit']       = 'cancel';
unset($act_buttons['clear']);

// create a class instance for the MAIN database table
require_once "classes/$table_id.class.inc";
if (isset($script_vars['dbobject'])) {
    // use data from previous instance for this script
    $dbobject = unserialize($script_vars['dbobject']);
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $dbobject->restart($return_from, $return_action, $return_string, $return_files);
    } // if
    // get data from this instance
    $fieldarray = $dbobject->getFieldArray();
    // redo any configuration changes
    $fieldarray = $dbobject->getExtraData($fieldarray);
} else {
    // create new instance for initial activation of this script
    $dbobject = new $table_id;
    // indicate that this object was started from a page controller
    $dbobject->initiated_from_controller = true;
    $dbouter->zone                      = 'main';
    $dbobject->sql_select     = &$sql_select;
    $dbobject->sql_from       = &$sql_from;
    $dbobject->sql_where      = &$sql_where;
    $dbobject->sql_groupby    = &$sql_groupby;
    $dbobject->sql_having     = &$sql_having;
    $dbobject->sql_orderby_table = &$sql_orderby_table;
    if (!empty($sql_orderby)) {
        $dbobject->setDefaultOrderby($sql_orderby);
    } elseif (!empty($task_orderby)) {
        $dbobject->setDefaultOrderby($task_orderby);
    } // if
    $dbobject->checkPrimaryKey = true;  // check that primary key is complete
    $dbobject->setRowsPerPage(1);   // scroll through items one at a time
    // perform any initialisation
    $where = $dbobject->initialise($original_where, $original_selection);
    // save $where in $scrollarray
    $scrolling[$dbobject->getClassName()]['where'] = $where;
    // get object to set scroll array internally
    $where  = $dbobject->setScrollArray($where);
    if ($dbobject->errors) {
        $messages = array_merge($messages, $dbobject->getMessages());
    	scriptprevious($dbobject->getErrors(), $messages, 'fail');
    } // if
} // if

if (isset($_POST['reset'])) {
    $where = $dbobject->reset($where);
    $fieldarray = $dbobject->getFieldArray();
    $scrolling[$dbobject->getClassName()]['curitem'] = 1;
    $dbobject->setScrollIndex(1);
    $where = $scrolling[$dbobject->getClassName()]['where'];
    $_POST = array();  // no further POST action required

} elseif (isset($_POST['delete'])) {
    // check that this record can be deleted
    $fieldarray = $dbobject->validateDelete($fieldarray);
    if ($dbobject->errors) {
        $errors = $dbobject->getErrors();
    } // if
    if (empty($errors)) {
        // delete the current record
        $dbobject->startTransaction();
        $fieldarray = $dbobject->deleteRecord($fieldarray);
        if ($errors) {
            $dbobject->rollback();
        } else {
            $errors = $dbobject->commit();
        } // if
        $messages = array_merge($messages, $dbobject->getMessages());
        if (empty($errors)) {
            // '$count records were deleted from $tablename'
            $messages[] = getLanguageText('sys0004', $dbobject->numrows, strtoupper($dbobject->tablename));

            if ($scrolling[$dbobject->getClassName()]['lastitem'] == 1) {
                // last item has been deleted, so return to previous screen
                scriptPrevious(null, $messages, 'delete', $dbobject->getInstruction());
            } // if

            if (empty($dbobject->scrollarray)) {
                // keep using current $where
            } else {
                // remove this item, get $where for next item
                $where = $dbobject->deleteScrollItem($dbobject->getScrollIndex());
            } // if

            // get next available record
            $fieldarray = $dbobject->getData($where);

            if (empty($dbobject->scrollarray)) {
                $scrolling[$dbobject->getClassName()]['curitem']  = $dbobject->getPageNo();
                $scrolling[$dbobject->getClassName()]['lastitem'] = $dbobject->getLastPage();
            } else {
                $scrolling[$dbobject->getClassName()]['curitem']  = $dbobject->getScrollIndex();
                $scrolling[$dbobject->getClassName()]['lastitem'] = $dbobject->getScrollSize();
            } // if

        } // if
    } // if
    $_POST = array();  // no further POST action required
} // if

if (!empty($_POST)) {
    // identify if one of the 'submit' buttons has been pressed
    $submit_button = check_submit_button($act_buttons, $_POST);
    $task_button   = check_task_button($_POST);
    $custom_button = check_custom_button($_POST);
    if ($submit_button OR $task_button OR $custom_button) {
        // merge original data with POSTed data (so that fields which were displayed
        // but not POSTed are sent back if any errors are displayed).
        $fieldarray = array_update_associative($fieldarray, $_POST, $dbobject->fieldspec);
        // ensure that changes are stored inside relevant object
        $dbobject->setFieldArray($fieldarray);

    } else {
        // deal with a javascript 'submit()'.
        $fieldarray = $dbobject->updateFieldArray($fieldarray, $_POST);
        if ($dbobject->errors) {
            $errors[$dbobject->getClassName()] = $dbobject->getErrors();
        } // if
    } // if

    if (empty($errors) AND !empty($task_button)) {
        // look for a navigation or popup button which jumps to another script
        $child_errors = childForm($_POST, array('dbobject' => $dbobject), $task_button);
        if (is_array($child_errors)) {
            $errors[$dbobject->getClassName()] = $child_errors;
        } // if

    } elseif (empty($errors) AND !empty($custom_button)) {
        // a custom button was pressed
        list($custom_btn, $btn_row, $btn_zone) = $custom_button;
        $dbobject->startTransaction();
        $fieldarray = $dbobject->customButton($fieldarray, $custom_btn, $_POST);
        if ($dbobject->errors) {
            $errors[$dbobject->getClassName()] = $dbobject->getErrors();
            $dbobject->rollback();
        } else {
            $dbobject->commit();
        } // if

    } elseif (empty($errors) AND !empty($submit_button)) {
        $dbobject->startTransaction();
        $dbobject->no_submit_on_error = true;
        // set $where to primary key of current record
        $pkeynames = $dbobject->getPkeyNamesAdjusted();
        $where = array2where($fieldarray, $pkeynames, $dbobject);
        // see if this record exists or not
        $count = $dbobject->getCount($where);
        if ($count == 0) {
            // record does not exist, so create it
            $mode = 'insert';
            $fieldarray = $dbobject->insertRecord($fieldarray);
            // '$count records were inserted into $tablename'
            $messages[] = getLanguageText('sys0005', $dbobject->numrows, strtoupper($dbobject->tablename));
        } else {
            // record does exist, so update it
            $mode = 'update';
            $fieldarray = $dbobject->updateRecord($fieldarray);
            // '$count records were updated in $tablename'
            $messages[] = getLanguageText('sys0006', $dbobject->numrows, strtoupper($dbobject->tablename));
        } // if
        if ($dbobject->errors) {
            $errors = $dbobject->getErrors();
            $dbobject->rollback();
        } else {
            $errors = $dbobject->commit();
        } // if
        $messages = array_merge($messages, $dbobject->getMessages());
        if (empty($errors)) {
            if (isset($_POST['submitnext'])) {
                // skip to the next available item
                $curitem  = $scrolling[$dbobject->getClassName()]['curitem'];
                $lastitem = $scrolling[$dbobject->getClassName()]['lastitem'];
                if ($curitem == $lastitem) {
                    // we are on the last item, so return to previous script
                    scriptPrevious($errors, $messages, $mode, $dbobject->getInstruction());
                } // if
                if (empty($dbobject->scrollarray)) {
                    // pick next item from the database
                    $where = $scrolling[$dbobject->getClassName()]['where'];
                    $curitem++;
                    $dbobject->setPageNo($curitem);
                } else {
                    // pick next item out of $scrollarray
                    $curitem++;
                    $where = $dbobject->getScrollItem($curitem);
                } // if

            } elseif (isset($_POST['submitBtn'])) {
                // update was OK - return to previous screen
                $prev_script = getPreviousScript();
                $prev_task   = getPreviousTask($prev_script);
                $messages = array_merge($messages, $dbobject->getMessages());
                scriptPrevious(null, $messages, $mode, $dbobject->getInstruction());
            } // if

            // read chosen record
            $fieldarray = $dbobject->getData($where);

            if (empty($dbobject->scrollarray)) {
                $scrolling[$dbobject->getClassName()]['curitem']  = $dbobject->getPageNo();
                $scrolling[$dbobject->getClassName()]['lastitem'] = $dbobject->getLastPage();
            } else {
                $scrolling[$dbobject->getClassName()]['curitem']  = $dbobject->getScrollIndex();
                $scrolling[$dbobject->getClassName()]['lastitem'] = $dbobject->getScrollSize();
            } // if
        } // if
    } // if
    $fieldarray = $dbobject->getFieldArray();
} // if

//if ($_SERVER['REQUEST_METHOD'] == 'GET') {
if (empty($errors)) {
    // check if we are returning from a child form
    if (!empty($return_from) AND isset($selection)) {
        // merge previous saved variables with selection from popup form
        $fieldarray = $dbobject->popupReturn($fieldarray, basename($return_from), $selection, null, $return_files);
        if ($dbobject->errors) {
            $errors = $dbobject->getErrors();
        } // if

    } else {
        if (isset($_GET['scrolling']) AND $_GET['scrolling'] == $dbobject->getClassName()) {
            // set index number of item to be read from current scrollarray
            $where = $dbobject->getScrollItem($_GET['item']);
        } // if

        if (!empty($return_from)) {
            // returning from a child screen, so don't lose current data
            // which may be for a new or modified record
        } else {
        	// retrieve record from the database
            $fieldarray = $dbobject->getData($where);
            if (empty($fieldarray)) {
                $fieldarray = where2array($where);  // nothing found, so use contents of $where
            } // if
            //$fieldarray = $dbobject->getExtraData($fieldarray);
        } // if
        if ($dbobject->errors) {
            $errors = $dbobject->getErrors();
            $messages = array_merge($messages, $dbobject->getMessages());
            if (empty($dbobject->scrollarray) OR count($dbobject->scrollarray) == 1) {
            	scriptPrevious($errors, $messages, 'fail');
            } // if
        } // if

        // the following lines are incorrect - if a record does NOT currently exist then
        // it should be possible to create one (terminating here is wrong!)
        //if (empty($dbobject->scrollarray)) {
            //if ($dbobject->numrows < 1) {
            //    scriptPrevious(getLanguageText('sys0081')); // 'Nothing has been selected yet.'
            //} // if
        if (!empty($errors)) {
        	if (!isset($scrolling[$dbobject->getClassName()])) {
        	    // only one entry selected, so return to previous screen to show the error
        		scriptPrevious($errors, $messages, 'fail');
        	} // if
        } // if

        if (empty($dbobject->scrollarray)) {
            $scrolling[$dbobject->getClassName()]['curitem']  = $dbobject->getPageNo();
            $scrolling[$dbobject->getClassName()]['lastitem'] = $dbobject->getLastPage();
        } else {
            $scrolling[$dbobject->getClassName()]['curitem']  = $dbobject->getScrollIndex();
            $scrolling[$dbobject->getClassName()]['lastitem'] = $dbobject->getScrollSize();
        } // if
    } // if
} // if

if (empty($errors)) {
    if ($dbobject->getNumRows() < 1) {
        // get initial data for a new record
        $fieldarray = $dbobject->getInitialData($fieldarray);
        $fieldarray = $dbobject->getExtraData($fieldarray);
        if ($dbobject->errors) {
            $messages = array_merge($messages, $dbobject->getMessages());
            scriptPrevious($dbobject->getErrors(), $messages, 'fail');
        } // if
    } else {
        // record exists in the database, so provide the option to delete it
        $act_buttons = array_merge(array('delete' => 'delete'), $act_buttons);
        $fieldarray = $dbobject->getExtraData($fieldarray);
        if ($dbobject->errors) {
            $messages = array_merge($messages, $dbobject->getMessages());
        } // if
    } // if
} // if

if (!empty($errors) AND is_True($dbobject->no_submit_on_error)) {
	// remove the SUBMIT button
    unset($act_buttons['submitBtn']);
    unset($act_buttons['submitnext']);
} // if

// save these variables for later in the same session
$script_vars['where']     = $where;
$script_vars['dbobject']  = serialize($dbobject);
$script_vars['scrolling'] = $scrolling;
$script_vars = updateScriptVars ($script_vars);

$dbobject->fieldarray = $fieldarray;  // replace data lost during serialization

if (!empty($_POST) AND empty($errors)) {
    // repeat current task with GET instead of POST
    scriptNext($GLOBALS['task_id'], $where);
} // if

//if (empty($errors)) {
//    if ($dbobject->getNumRows() > 0) {
//        // record exists in the database, so provide the option to delete it
//        $act_buttons = array_merge(array('delete' => 'delete'), $act_buttons);
//    } // if
//} // if

if (!empty($errors)) {
    // all errors are associated with this table
	$errors = array($dbobject->getClassName() => $errors);
} // if

$messages = array_merge($messages, $dbobject->getMessages());

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbobject;

// build XML document and perform XSL transformation
$view = new radicore_view($screen_structure);
$view->buildXML($xml_objects, $errors, $messages);
exit;

?>
