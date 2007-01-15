<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2007 by Radicore Software Limited <http://www.radicore.org>
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

if (isset($_POST['quit'])) {
    // cancel this screen, return to previous screen
    scriptPrevious(null, null, 'quit');
} // if

// define action buttons
$act_buttons['copy']       = 'copy';
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
    // set sort order (if defined)
    if (!empty($order_by)) {
        $string = validateSortItem('main', $order_by, $dbobject, $screen_structure);
        $dbobject->setOrderBy($string);
        if (!empty($order_by_seq)) {
            $dbobject->setOrderBySeq($order_by_seq);
        } // if
    } // if
    // perform any initialisation
    if (!empty($selection)) {
        $selection = $dbobject->initialise($selection, $where);
    } else {
        $where = $dbobject->initialise($where);
    } // if
} // if

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    // check if we are returning from a child form
    if (!empty($return_from) AND $return_action == 'choose') {
        if (isset($selection)) {
            // merge previous saved variables with selection from popup form
            $fieldarray = $dbobject->popupReturn($fieldarray, basename($return_from), $selection);
            if ($dbobject->errors) {
            	$errors[$dbobject->getClassName()] = $dbobject->getErrors();
            } // if
        } // if
        // some data may have been changed in the child form, so refresh it
        $fieldarray = $dbobject->getExtraData($fieldarray);
    } else {
        if (!empty($selection)) {
            // retrieve profile has been passed down from previous screen
            $where     = $selection;
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

        // get data from the database
        $fieldarray = $dbobject->getData($where);
        if ($dbobject->errors) {
            // some sort of error - return to previous script
            $messages = array_merge($messages, $dbobject->getMessages());
            scriptprevious($dbobject->getErrors(), $messages);
        } // if
        if ($dbobject->getNumRows() < 1) {
            scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
        } // if

        // set variables to be included in XML output
        $scrolling[$dbobject->getClassName()]['curitem']  = $dbobject->getPageNo();
        $scrolling[$dbobject->getClassName()]['lastitem'] = $dbobject->getLastPage();
        $scrolling[$dbobject->getClassName()]['where']    = $where;

        // get any extra data and merge with $fieldarray
        $fieldarray = $dbobject->getExtraData($fieldarray);

        // rebuild selection criteria using primary key of 1st occurrence
        $where = array2where($fieldarray, $dbobject->getPkeyNames(), $dbobject);
    } // if

    $messages = array_merge($messages, $dbobject->getMessages());

} // if

// look for entered data
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_POST['paste'])) {
        // merge initial data with previously saved data
        $fieldarray = array_merge_nonkey($dbobject->fieldspec, $fieldarray, $_SESSION['data'][$dbobject->tablename]);
        $fieldarray = $dbobject->getExtraData($fieldarray);
    } elseif (isset($_POST['copy'])) {
        $messages = copyForm($_POST, $dbobject);
    } else {
        // merge original data with POSTed data (so that fields which were displayed
        // but not POSTed are sent back if any errors are displayed).
        $fieldarray = array_update_associative($fieldarray, $_POST);
        // ensure that changes are stored inside relevant object
        $dbobject->setFieldArray($fieldarray);
        // look for an action which is another script
        $errors = childForm($_POST, array('dbobject' => $dbobject), $where);
        if (empty($errors)) {
            $dbobject->startTransaction();
            // update this data in the database
            $fieldarray = $dbobject->updateRecord($fieldarray);
            if ($dbobject->errors) {
				// errors are keyed by object name
			    $errors[$dbobject->getClassName()] = $dbobject->getErrors();
			} // if
            $messages = $dbobject->getMessages();
            if (empty($errors)) {
                $errors = $dbobject->commit();
            } // if
            if (!empty($errors)) {
                $dbobject->rollback();
            } else {
                if (empty($messages)) {
                    if ($dbobject->numrows > 0) {
                    	$messages[] = getLanguageText('sys0092'); // 'Record updated OK'
                    } // if
                } // if
                if ($scrolling[$dbobject->getClassName()]['lastitem'] <= 1) {
                    // update was OK, no more items, so return to previous screen
                    scriptPrevious($errors, $messages, 'OK', $dbobject->getInstruction());
                } else {
                    if (isset($_POST['submitnext'])) {
                        $curitem  = $scrolling[$dbobject->getClassName()]['curitem'];
                        $lastitem = $scrolling[$dbobject->getClassName()]['lastitem'];
                        if ($curitem < $lastitem) {
                            // skip to the next item
                            $curitem++;
                            $scrolling[$dbobject->getClassName()]['curitem'] = $curitem;
                            $dbobject->setPageNo($curitem);
                            $where = $scrolling[$dbobject->getClassName()]['where'];
                            $fieldarray = $dbobject->getData($where);
                            $scrolling[$dbobject->getClassName()]['lastitem'] = $dbobject->getLastPage();
                        } else {
                            // update was OK - return to previous screen
                            scriptPrevious($errors, $messages, 'OK', $dbobject->getInstruction());
                        } // if
                    } else {
                        // re-read database in case any other values have been changed
                        $fieldarray = $dbobject->getData($where);
                    } // if
                    if ($dbobject->numrows == 0) {
                        // record cannot be found, so re-read using original $where clause
                        $where      = $scrolling[$dbobject->getClassName()]['where'];
                        $fieldarray = $dbobject->getData($where);
                        // reset 'lastitem' in scroll array
                        $scrolling[$dbobject->getClassName()]['lastitem'] = $dbobject->getLastPage();
                        $script_vars['scrolling'] = $scrolling;
                    } // if
                    // get any extra data and merge with $fieldarray
                    $fieldarray = $dbobject->getExtraData($fieldarray);
                    // rebuild selection criteria using primary key of 1st occurrence
                    $where = array2where($fieldarray, $dbobject->getPkeyNames(), $dbobject);
                } // if
            } // if
        } // if
    } // if
} // if

if (isset($_SESSION['data'][$dbobject->tablename])) {
    // saved data exists, so allow a PASTE button
    $prepend = array('paste' => 'paste');
    $act_buttons = array_merge($prepend, $act_buttons);
} // if

// save these variables for later in the same session
$script_vars['where']     = $where;
$script_vars['dbobject']  = serialize($dbobject);
$script_vars['scrolling'] = $scrolling;
$script_vars = updateScriptVars ($script_vars);

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbobject;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);
exit;

?>
