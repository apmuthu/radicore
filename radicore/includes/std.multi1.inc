<?php
// *****************************************************************************
// Copyright 2003-2006 by A J Marston <http://www.tonymarston.net>
// Licensed to Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.multi1.inc

// type = multi1

// This will allow one (or more) database record(s) to be updated, or inserted if
// it/they do not currently exist.
// The primary key of the selected record is passed down in $where.
// NOTE: scrolling is done via the setScrollArray() and getScrollItem() methods.

// NOTE: the CLEAR button is optional, and is set in the previous script. This
// also causes the RETRIEVE and DELETE buttons to appear.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'update';

// load session variables
initSession();

if (isset($_POST['quit'])) {
    // cancel this screen, return to previous screen
    scriptPrevious(null, null, 'quit');
} // if

// define action buttons
$act_buttons['submit']     = 'submit';
$act_buttons['submitnext'] = 'submitnext';
$act_buttons['quit']       = 'cancel';

// create a class instance for the MAIN database table
require_once "classes/$table_id.class.inc";
if (isset($script_vars['dbobject'])) {
    // use data from previous instance for this script
    $dbobject = unserialize($script_vars['dbobject']);
    // get previous data
    $fieldarray = $dbobject->getFieldArray();
} else {
    // create new instance for initial activation of this script
    $dbobject = new $table_id;
    $dbobject->sql_select     = &$sql_select;
    $dbobject->sql_from       = &$sql_from;
    $dbobject->sql_where      = &$sql_where;
    $dbobject->sql_groupby    = &$sql_groupby;
    $dbobject->sql_having     = &$sql_having;
    $dbobject->sql_sort_table = &$sql_sort_table;
    if (!empty($sql_orderby)) {
        $dbobject->setDefaultOrderby($sql_orderby);
    } elseif (!empty($task_order_by)) {
        $dbobject->setDefaultOrderby($task_order_by);
    } // if
    // check that primary key is complete
    $dbobject->checkPrimaryKey = true;
    // scroll through one item at a time
    $dbobject->setRowsPerPage(1);
    if (isset($sql_where) and strlen($sql_where) > 0) {
        // merge two strings into one
    	$where = mergeWhere($where, $sql_where);
    	$dbobject->sql_where = null;
    } // if
    // perform any initialisation
    $where = $dbobject->initialise($where, $selection);
} // if

if (isset($_POST['clear'])) {
    // clear current selection
    $where      = null;
    $selection  = null;
    // clear internal scrollarray
    $dbobject->clearScrollArray();
    // clear internal fieldarray
    $dbobject->setFieldArray(null);
    // initialise scroll array
    $scrolling[$dbobject->getClassName()]['where']    = null;
    $scrolling[$dbobject->getClassName()]['curitem']  = 0;
    $scrolling[$dbobject->getClassName()]['lastitem'] = 0;
    $mode = 'insert';
    // include a RETRIEVE button
    $act_buttons = array_merge(array('retrieve' => 'retrieve'), $act_buttons);
} // if

if (isset($_POST['retrieve'])) {
    // set $where to primary key of current record (check for profile characters)
    $where = array2where($_POST, $dbobject->getPkeyNames(), $dbobject);
    // get data from the database
    $fieldarray = $dbobject->getData($where);
    $errors = $dbobject->getErrors();
    if (!$errors) {
        if ($dbobject->getNumRows() < 1) {
            // get initial data for a new record
            $fieldarray = $dbobject->getInitialData($where);
            $errors[]   = getLanguageText('sys0089'); // 'Nothing was found matching this profile'
        } else {
            // get extra data for lookup lists
            $fieldarray = $dbobject->getExtraData($fieldarray);
            // set new scrolling values
            $scrolling[$dbobject->getClassName()]['curitem']  = $dbobject->getPageNo();
            $scrolling[$dbobject->getClassName()]['lastitem'] = $dbobject->getLastPage();
            $scrolling[$dbobject->getClassName()]['where']    = $where;
        } // if
    } // if
    if ($errors) {
        // include a RETRIEVE button for another attempt
        $act_buttons = array_merge(array('retrieve' => 'retrieve'), $act_buttons);
        $mode = 'insert';
    } // if
} // if

if (isset($_POST['delete'])) {
    // delete the current record
    $dbobject->startTransaction();
    $fieldarray = $dbobject->deleteRecord($fieldarray);
    $errors     = $dbobject->getErrors();
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
    if (!empty($return_from)) {
        if ($return_action == 'choose' AND !empty($selection)) {
            // merge previous saved variables with selection from popup form
            $fieldarray = $dbobject->popupReturn($fieldarray, basename($return_from), $selection);
            $errors     = array_merge($errors, $dbobject->getErrors());
        } // if
    } else {
        if (!empty($selection)) {
            // use selection from previous screen
            $where     = $selection;
            $selection = null;

            // save $where in $scrollarray
            $scrolling[$dbobject->getClassName()]['where'] = $where;

            // get object to set scroll array internally
            $where  = $dbobject->setScrollArray($where);
            $errors = $dbobject->getErrors();
            if ($errors) {
                // beam me up, Scotty!
                scriptprevious($errors);
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
        } // if

        // retrieve record from the database
        $fieldarray = $dbobject->getData($where);

        if (empty($dbobject->scrollarray)) {
            if ($dbobject->numrows < 1) {
                scriptPrevious(getLanguageText('sys0081')); // 'Nothing has been selected yet.'
            } // if
            $scrolling[$dbobject->getClassName()]['curitem']  = $dbobject->getPageNo();
            $scrolling[$dbobject->getClassName()]['lastitem'] = $dbobject->getLastPage();
        } else {
            $scrolling[$dbobject->getClassName()]['curitem']  = $dbobject->getScrollIndex();
            $scrolling[$dbobject->getClassName()]['lastitem'] = $dbobject->getScrollSize();
        } // if

    } // if
} // if

// look for entered data
if (isset($_POST['submit']) or isset($_POST['submitnext'])) {
    // merge original data with POSTed data (so that fields which were displayed
    // but not POSTed are sent back if any errors are displayed).
    $fieldarray = array_update($fieldarray, $_POST);
    // check that primary key contains no wildcard characters
    $errors = isPkeyComplete($fieldarray, $dbobject->getPkeyNames());
    if (empty($errors)) {
        // set $where to primary key of current record
        $where = array2where($fieldarray, $dbobject->getPkeyNames(), $dbobject);
        // look for an action which is another script
        $errors = childForm($_POST, $dbobject, 'dbobject', $where, $fieldarray);
    } else {
        $mode = 'insert';
        $dbobject->setFieldArray($fieldarray);
    } // if
    if (empty($errors)) {
        $dbobject->startTransaction();
        $count = $dbobject->getCount($where);
        if ($count == 0) {
            // record does not exist, so create it
            $fieldarray = $dbobject->insertRecord($fieldarray);
        } else {
            // record does exist, so update it
            $fieldarray = $dbobject->updateRecord($fieldarray);
        } // if
        if (count($dbobject->getErrors()) > 0) {
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
                    scriptPrevious($errors, $messages, 'OK', $dbobject->getInstruction());
                } // if
                if (empty($dbobject->scrollarray)) {
                    // pick next item from the database
                    $where = $scrolling[$dbobject->getClassName()]['where'];
                    $dbobject->setPageNo($curitem +1);
                } else {
                    // pick next item out of $scrollarray
                    $where = $dbobject->getScrollItem($curitem +1);
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

if (!$errors) {
    if ($dbobject->getNumRows() < 1) {
        // get initial data for a new record
        $fieldarray = $dbobject->getInitialData($where);
        if ($dbobject->getErrors()) {
            scriptPrevious($dbobject->getErrors(), $messages);
        } // if
    } // if

    // get any extra data and merge with $fieldarray
    $fieldarray = $dbobject->getExtraData($fieldarray);
    $errors     = $dbobject->getErrors();
    if ($errors) {
        // remove the SUBMIT button
        unset($act_buttons['submit']);
    } // if
} // if

// ensure script variables are available throughout this session
unset($script_vars['selection']);
$script_vars['where']     = $where;
$script_vars['dbobject']  = serialize($dbobject);
$script_vars['scrolling'] = $scrolling;
$PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'
$_SESSION[$PHP_SELF][$task_id] = $script_vars;

if (!$errors) {
    if ($dbobject->getNumRows() > 0) {
        if (array_key_exists('clear', $act_buttons)) {
            $act_buttons = array_merge(array('delete' => 'delete'), $act_buttons);
        } // if
    } // if
} // if

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbobject;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);
exit;

?>
