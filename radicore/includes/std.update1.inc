<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2011 by Radicore Software Limited <http://www.radicore.org>
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
$act_buttons['copy']       = 'copy';
$act_buttons['submit']     = 'submit';
//$act_buttons['submitstay'] = 'submitstay';  // this is usually hidden
$act_buttons['submitnext'] = 'submitnext';
$act_buttons['quit']       = 'cancel';

// create a class instance for the MAIN database table
require_once "classes/$table_id.class.inc";
if (isset($script_vars['dbobject'])) {
    // use data from previous instance for this script
    $dbobject = unserialize($script_vars['dbobject']);
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $dbobject->restart($return_from, $return_action);
    } // if
    // get data from previous instance
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

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    // check if we are returning from a child form
    if (!empty($return_from) AND !empty($popup_object)) {
        if (isset($selection)) {
            // merge previous saved variables with selection from popup form
            $fieldarray = $dbobject->popupReturn($fieldarray, basename($return_from), $selection);
            if ($dbobject->errors) {
            	$errors = $dbobject->getErrors();
            } // if
            // some data may have been changed in the child form, so refresh it
            $fieldarray = $dbobject->getExtraData($fieldarray);
            if ($dbobject->errors) {
            	$errors = $dbobject->getErrors();
            } // if
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
            $result = $dbobject->validateUpdate($fieldarray);
        } // if
        if ($dbobject->errors) {
            if ($dbobject->numrows > 1) {
                // multiple rows, so display error message with this screen
                $errors = $dbobject->getErrors();
            } else {
                // single row, so return to previous script before displaying error message
                $messages = array_merge($messages, $dbobject->getMessages());
                scriptprevious($dbobject->getErrors(), $messages);
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

        // get any extra data and merge with $fieldarray
        $fieldarray = $dbobject->getExtraData($fieldarray);
        if ($dbobject->errors) {
        	$errors = $dbobject->getErrors();
        } // if

        // rebuild selection criteria using primary key of 1st occurrence
        $where = array2where($fieldarray, $dbobject->getPkeyNames(), $dbobject);

        if (!empty($errors)) {
            // switch the whole zone into 'noedit' mode
            $dbobject->xsl_params['main_noedit'] = 'y';
            unset($act_buttons['submit']);
            unset($act_buttons['submitnext']);
        } // if
    } // if
} // if

// look for entered data
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_POST['paste'])) {
        // merge initial data with previously saved data
        $fieldarray = pasteData($dbobject->fieldspec, $fieldarray, $_SESSION['data'][$dbobject->tablename]);
        $fieldarray = $dbobject->getExtraData($fieldarray);
        if ($dbobject->errors) {
        	$errors = $dbobject->getErrors();
        } // if
    } elseif (isset($_POST['copy'])) {
        $messages = copyForm($_POST, $dbobject);
    } else {
        // merge original data with POSTed data (so that fields which were displayed
        // but not POSTed are sent back if any errors are displayed).
        $fieldarray = array_update_associative($fieldarray, $_POST, $dbobject->fieldspec);
        // ensure that changes are stored inside relevant object
        $dbobject->setFieldArray($fieldarray);
        // look for an action which is another script
        $errors = childForm($_POST, array('dbobject' => $dbobject));
        if (empty($errors)) {
            // look for a custom button (a field which begins with 'button#')
		    $button = false;
            foreach ($_POST as $postname => $postvalue) {
            	if (preg_match('/^button#/i', $postname, $regs)) {
            	    // strip off the prefix to leave the original field name
            		$button = str_replace($regs[0], '', $postname);
            		break;
            	} // if
            } // foreach
            if ($button) {
            	// a custom button was pressed
            	$fieldarray = $dbobject->customButton($fieldarray, $button);
            	if ($dbobject->errors) {
                    $errors = $dbobject->getErrors();
                } // if
            } else {
                $dbobject->startTransaction();
                // update this data in the database
                $fieldarray = $dbobject->updateRecord($fieldarray);
                if ($dbobject->errors) {
    				$errors = $dbobject->getErrors();
    			} // if
                $messages = $dbobject->getMessages();
                if (empty($errors)) {
                    $errors = $dbobject->commit();
                } // if
                if (!empty($errors)) {
                    $dbobject->rollback();
                } else {
                    if ($dbobject->numrows > 0) {
                    	$messages[] = getLanguageText('sys0092'); // 'Record updated OK'
                    } // if
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
                            // no more items, so return to previous screen
                            scriptPrevious($errors, $messages, 'OK', $dbobject->getInstruction());
                        } // if
                    } elseif (isset($_POST['submit'])) {
                        if ($scrolling[$dbobject->getClassName()]['lastitem'] <= 1) {
                            // update was OK, no more items, so return to previous screen
                            scriptPrevious($errors, $messages, 'OK', $dbobject->getInstruction());
                        } // if
                    } // if
                    // treat as if 'submitstay' button was pressed and stay on current record

                    // re-read database in case any other values have been changed
                    $fieldarray = $dbobject->getData($where);
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
                    if ($dbobject->errors) {
                        $errors = $dbobject->getErrors();
                    } // if
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

if (!empty($dbobject->messages)) {
    $messages = array_merge($messages, $dbobject->getMessages());
    $messages = array_unique($messages);
} // if

// save these variables for later in the same session
$script_vars['where']     = $where;
$script_vars['dbobject']  = serialize($dbobject);
$script_vars['scrolling'] = $scrolling;
$script_vars = updateScriptVars ($script_vars);

if ($_SERVER['REQUEST_METHOD'] == 'POST' AND empty($errors) AND !$button) {
    // repeat current task with GET instead of POST
    scriptNext($GLOBALS['task_id'], $where);
} // if

//if (isset($dbobject->xsl_params['main_noedit'])) {
//	unset($act_buttons['submit']);
//    unset($act_buttons['submitnext']);
//} // if

if (!empty($errors)) {
    // all errors are associated with this table
	$errors2[$dbobject->getClassName()] = $errors;
	$errors = $errors2;
} // if

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbobject;

// build XML document and perform XSL transformation
$view = new radicore_view($screen_structure);
$view->buildXML($xml_objects, $errors, $messages);
exit;

?>
