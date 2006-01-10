<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.erase1.inc

// type = erase1

// Delete a single selected occurrence, and all its children, from the database.
// The primary key of the row is passed in $where from the previous screen.
// If multiple entries were selected in the prevous screen then a scrollbar
// will be made available for the user to scroll between these entries.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'delete';

// load session variables
initSession();

if (isset($_POST['quit'])) {
    // cancel this screen, return to previous screen
    scriptPrevious(null, null, 'quit');
} // if

// define action buttons
$act_buttons['submit'] = 'submit';
$act_buttons['quit']   = 'cancel';

// create a class instance for the main database table
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
    $dbobject->sql_select  = &$sql_select;
    $dbobject->sql_from    = &$sql_from;
    $dbobject->sql_where   = &$sql_where;
    $dbobject->sql_groupby = &$sql_groupby;
    $dbobject->sql_having  = &$sql_having;
    // scroll through one item at a time
    $dbobject->setRowsPerPage(1);
    // check that primary key is complete
    $dbobject->checkPrimaryKey = true;
} // if

// look for SUBMIT button
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_POST['copy'])) {
        $messages = copyForm($_POST, $dbobject, $fieldarray);
    } else {
        // look for an action which is another script
        $errors = childForm($_POST, $dbobject, 'dbobject', $where, $fieldarray);
        if (empty($errors)) {
            $dbobject->startTransaction();
            // delete this record from the database
            $fieldarray = $dbobject->eraseRecord($fieldarray);
            // retrieve errors from database object
            $errors = $dbobject->getErrors();
            if (empty($errors)) {
                $errors = $dbobject->commit();
            } // if
            $messages[] = 'Item has been erased';
            if (empty($errors)) {
                if ($scrolling[$dbobject->getClassName()]['lastitem'] == 1) {
                    // last item has been deleted, so return to previous screen
                    scriptPrevious(null, $messages, 'OK', $dbobject->getInstruction());
                } // if
            } else {
                $dbobject->rollback();
            } // if
        } // if
    } // if
} // if

if (!empty($selection)) {
    // retrieve profile has been passed down from previous screen
    $where = $selection;
    $selection = null;
} else {
    if (isset($scrolling)) {
        // retrieve values from scrolling array
        $where = $scrolling[$dbobject->getClassName()]['where'];
        $dbobject->setPageNo($scrolling[$dbobject->getClassName()]['curitem']);
    } // if
} // if
if (empty($where)) {
    scriptPrevious(getLanguageText('sys0081')); // 'Nothing has been selected yet.'
} // if

if (isset($_GET['scrolling']) AND $_GET['scrolling'] == $dbobject->getClassName()) {
    // set index number of item to be read from current $where list
    $dbobject->setPageNo($_GET['item']);
} // if

if (!empty($order_by)) {
    // records need to be sorted
    $dbobject->setOrderby($order_by);
    if (!empty($order_by_seq)) {
        $dbobject->setOrderBySeq($order_by_seq);
    } // if
} // if

// get data from the database
$fieldarray = $dbobject->getData($where);
if ($dbobject->getErrors()) {
    // some sort of error - return to previous script
    scriptprevious($dbobject->getErrors(), $messages);
} // if
if ($dbobject->getNumRows() < 1) {
    scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
} // if

// set scrolling variables to be included in XML output
$scrolling[$dbobject->getClassName()]['curitem']  = $dbobject->getPageNo();
$scrolling[$dbobject->getClassName()]['lastitem'] = $dbobject->getLastPage();
$scrolling[$dbobject->getClassName()]['where']    = $where;

// if ($_SERVER['REQUEST_METHOD'] == 'GET') {
if (empty($errors)) {
    // get any extra data and merge with $fieldarray
    $fieldarray = $dbobject->getExtraData($fieldarray);
} // if

if ($errors) {
    // remove the 'submit' button
    unset($act_buttons['submit']);
} else {
    //$messages[] = getLanguageText('sys0086'); // 'Press SUBMIT to confirm deletion.'
    $messages[] = 'Press SUBMIT to erase this entry, and ALL child entries, from the database.';
} // if

unset($script_vars['selection']);
$script_vars['where']     = $where;
$script_vars['scrolling'] = $scrolling;
$script_vars['dbobject']  = serialize($dbobject);
$PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'
$_SESSION[$PHP_SELF][$task_id] = $script_vars;

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbobject;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);
exit;

?>
