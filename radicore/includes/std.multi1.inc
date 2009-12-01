<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2009 by Radicore Software Limited <http://www.radicore.org>
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
$act_buttons['submit']     = 'submit';
$act_buttons['submitnext'] = 'submitnext';
$act_buttons['reset']      = 'reset';
$act_buttons['quit']       = 'cancel';
unset($act_buttons['clear']);

// create a class instance for the MAIN database table
require_once "classes/$table_id.class.inc";
if (isset($script_vars['dbobject'])) {
    // use data from previous instance for this script
    $dbobject = unserialize($script_vars['dbobject']);
    // get previous data
    $fieldarray = $dbobject->getFieldArray();
    if (!is_string(key($fieldarray))) {
        // indexed by row, so use first row only
        $fieldarray = $fieldarray[key($fieldarray)];
    } // if
} else {
    // create new instance for initial activation of this script
    $dbobject = new $table_id;
    // indicate that this object was started from a page controller
    $dbobject->initiated_from_controller = true;
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
    // check that primary key is complete
    $dbobject->checkPrimaryKey = true;
    // scroll through one item at a time
    $dbobject->setRowsPerPage(1);
    // perform any initialisation
    $where = $dbobject->initialise($original_where, $original_selection);
    // save $where in $scrollarray
    $scrolling[$dbobject->getClassName()]['where'] = $where;
    // get object to set scroll array internally
    $where  = $dbobject->setScrollArray($where);
    if ($dbobject->errors) {
    	scriptprevious($dbobject->getErrors());
    } // if
} // if

if (isset($_POST['reset'])) {
    // ignore current changes and reset to prior state
    unset($_POST);
} // if

if (isset($_POST['delete'])) {
    // delete the current record
    $dbobject->startTransaction();
    $fieldarray = $dbobject->deleteRecord($fieldarray);
    if ($dbobject->errors) {
    	$errors[$dbobject->getClassName()] = $dbobject->getErrors();
    } // if
    if ($errors) {
        $dbobject->rollback();
    } else {
        $errors = $dbobject->commit();
    } // if
    if (empty($errors)) {
        if ($scrolling[$dbobject->getClassName()]['lastitem'] == 1) {
            // last item has been deleted, so return to previous screen
            scriptPrevious(null, null, 'OK', $dbobject->getInstruction());
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

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    // check if we are returning from a child form
    if (!empty($return_from) AND !empty($popup_object)) {
        if (isset($selection)) {
            // merge previous saved variables with selection from popup form
            $fieldarray = $dbobject->popupReturn($fieldarray, basename($return_from), $selection);
            if ($dbobject->errors) {
            	$errors[$dbobject->getClassName()] = $dbobject->getErrors();
            } // if
        } // if
    } else {
        if (isset($_GET['scrolling']) AND $_GET['scrolling'] == $dbobject->getClassName()) {
            if (empty($dbobject->scrollarray)) {
            	$dbobject->setPageNo($_GET['item']);
            } else {
                // set index number of item to be read from current scrollarray
                $where = $dbobject->getScrollItem($_GET['item']);
            } // if
        } // if

        // retrieve record from the database
        $fieldarray = $dbobject->getData($where);
        if ($dbobject->errors) {
            if (empty($dbobject->scrollarray) OR count($dbobject->scrollarray) == 1) {
                $errors = $dbobject->getErrors();
//                foreach ($errors as $key => $value) {
//                    $errors[$where] = $value;
//                    unset($errors[$key]);
//                } // foreach
            	scriptPrevious($errors);
            } else {
        	    $errors[$dbobject->getClassName()] = $dbobject->getErrors();
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
        		scriptPrevious($errors);
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

// look for entered data
//if (isset($_POST['submit']) or isset($_POST['submitnext'])) {
//if ($_SERVER['REQUEST_METHOD'] == 'POST') {
if (!empty($_POST)) {
    // merge original data with POSTed data (so that fields which were displayed
    // but not POSTed are sent back if any errors are displayed).
    $fieldarray = array_update_associative($fieldarray, $_POST);
    // check that primary key contains no wildcard characters
    $errors = isPkeyComplete($fieldarray, $dbobject->getPkeyNames());
    if (empty($errors)) {
        // set $where to primary key of current record
        $pkeynames = $dbobject->getPkeyNamesAdjusted();
        $where = array2where($fieldarray, $pkeynames, $dbobject);
        // ensure that changes are stored inside relevant object
        $dbobject->setFieldArray($fieldarray);
        // look for an action which is another script
        $errors = childForm($_POST, array('dbobject' => $dbobject));
    } else {
        $dbobject->setFieldArray($fieldarray);
    } // if
    if (empty($errors)) {
        $dbobject->startTransaction();
        $count = $dbobject->getCount($where);
        if ($count == 0) {
            // record does not exist, so create it
            $mode = 'insert';
            $fieldarray = $dbobject->insertRecord($fieldarray);
        } else {
            // record does exist, so update it
            $mode = 'update';
            $fieldarray = $dbobject->updateRecord($fieldarray);
        } // if
        if ($dbobject->errors) {
			// errors are keyed by object name
		    $errors[$dbobject->getClassName()] = $dbobject->getErrors();
		} // if
        if ($errors) {
            $dbobject->rollback();
        } else {
            $errors = $dbobject->commit();
        } // if
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
} // if

if (empty($errors)) {
    if ($dbobject->getNumRows() < 1) {
        // get initial data for a new record
        $fieldarray = $dbobject->getInitialData($where);
        if ($dbobject->errors) {
            scriptPrevious($dbobject->getErrors(), $messages);
        } // if
    } // if

    // get any extra data and merge with $fieldarray
    $fieldarray = $dbobject->getExtraData($fieldarray);
    if ($dbobject->errors) {
    	$errors[$dbobject->getClassName()] = $dbobject->getErrors();
        // remove the SUBMIT button
        unset($act_buttons['submit']);
    } // if
} // if

// save these variables for later in the same session
$script_vars['where']     = $where;
$script_vars['dbobject']  = serialize($dbobject);
$script_vars['scrolling'] = $scrolling;
$script_vars = updateScriptVars ($script_vars);

//if ($_SERVER['REQUEST_METHOD'] == 'POST' AND empty($errors)) {
if (!empty($_POST) AND empty($errors)) {
    // repeat current task with GET instead of POST
    scriptNext($GLOBALS['task_id'], $where);
} // if

if (empty($errors)) {
    if ($dbobject->getNumRows() > 0) {
        $act_buttons = array_merge(array('delete' => 'delete'), $act_buttons);
    } // if
} // if

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbobject;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);
exit;

?>
