<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2011 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.link1.inc

// type = link1

// This deals with a MANY-to-MANY relationship by using an intermediate LINK table
// to provide a MANY-to-LINK-to-MANY structure. Each MANY-to-LINK relationship can
// now be treated as a standard ONE-to-MANY relationship.
// This version allows only one occurrence of LINK to exist for a combination of
// MANY(outer) and MANY(inner). The existence of an occurrence is treated as 'YES'
// while the non-existence of an occurrence is treated as 'NO'.
// A single occurrence of MANY(outer) must be selected, after which all available
// occurrence of MANY(inner) will be shown with a checkbox to signify if an occurrence
// of the LINK table exists or not.
// All the user has to do to add or delete occurrences of the LINK table is to toggle
// the setting of each checkbox.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'update';

// load session variables
initSession();

if (!empty($selection) AND (!isset($return_from) OR $return_action == 'choose')) {
    // $selection takes precedence over $where
    //$where     = $selection;
    //$selection = null;
    $new_selection = true;
} else{
    $new_selection = false;
} // if

if (isset($_POST['quit'])) {
    // close this screen, return to previous screen
    scriptPrevious(null, null, 'quit');
} // if

// define action buttons
$act_buttons['reset']      = 'reset';
$act_buttons['submit']     = 'submit';
$act_buttons['submitstay'] = 'submitstay';
$act_buttons['submitnext'] = 'submitnext';
$act_buttons['quit']       = 'cancel';

// create a class instance for the OUTER database table
require_once "classes/$outer_table.class.inc";
if (isset($script_vars['dbouter'])) {
    // recreate previous instance of this object
    $dbouter = unserialize($script_vars['dbouter']);
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $dbouter->restart($return_from, $return_action);
    } // if
    // get data rom previous instance
    $outer_data = $dbouter->getFieldArray();
} else {
    // create new instance for initial activation of this script
    $dbouter = new $outer_table;
    // indicate that this object was started from a page controller
    $dbouter->initiated_from_controller = true;
    $dbouter->zone                      = 'outer';
    $dbouter->sql_select     = &$outer_sql_select;
    $dbouter->sql_from       = &$outer_sql_from;
    $dbouter->sql_where      = &$outer_sql_where;
    $dbouter->sql_groupby    = &$outer_sql_groupby;
    $dbouter->sql_having     = &$outer_sql_having;
    $dbouter->sql_orderby_table = &$outer_sql_orderby_table;
    if (!empty($outer_sql_orderby)) {
        $dbouter->setDefaultOrderby($outer_sql_orderby);
    } //if
    // scroll through one item at a time
    $dbouter->setRowsPerPage(1);
    // check that primary key is complete
    $dbouter->checkPrimaryKey = true;
    // perform any initialisation
    $where = $dbouter->initialise($where, $selection);
    if ($dbouter->errors) {
        scriptPrevious($dbouter->getErrors());
    } // if
    // set sort order (if defined)
    if (!empty($orderby)) {
        $string = validateSortItem('outer', $orderby, $dbouter, $screen_structure);
        $dbouter->setOrderBy($string);
        if (!empty($orderby_seq)) {
            $dbouter->setOrderBySeq($orderby_seq);
        } // if
    } // if
} // if

// create a class instance for the LINK database table
require_once "classes/$link_table.class.inc";
if (isset($script_vars['dblink'])) {
    // recreate previous instance of this object
    $dblink = unserialize($script_vars['dblink']);
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $dblink->restart($return_from, $return_action);
    } // if
    // get data rom previous instance
    $link_data = $dblink->getFieldArray();
} else {
    // create new instance for initial activation of this script
    $dblink = new $link_table;
    // indicate that this object was started from a page controller
    $dblink->initiated_from_controller = true;
    $dblink->zone                      = 'link';
    $dblink->sql_select       = &$link_sql_select;
    $dblink->sql_from         = &$link_sql_from;
    $dblink->sql_where        = &$link_sql_where;
    $dblink->sql_groupby      = &$link_sql_groupby;
    $dblink->sql_having       = &$link_sql_having;
    $dblink->sql_orderby_table = &$link_sql_orderby_table;
    $dblink->sql_search_table  = &$link_search_table;
    if (!empty($link_sql_orderby)) {
        $dblink->setDefaultOrderby($link_sql_orderby);
    } elseif (!empty($task_orderby)) {
        $dblink->setDefaultOrderby($task_orderby);
    } // if
    // these are used to signify an outer-link-inner relationship
    $dblink->outer_table    = $outer_table;
    $dblink->inner_table    = $inner_table;
    $dblink->is_link_table  = TRUE;
} // if

if (!empty($_POST)) {
    // merge original data with user's input (so that fields which were displayed
    // but not POSTed are sent back if any errors are displayed).
    $link_data = array_update_indexed($link_data, $_POST);
    // ensure that changes are stored inside relevant object
    $dblink->setFieldArray($link_data);
    // look for an action which is another script
    $errors = childForm($_POST, array('dblink' => $dblink));
    if (empty($errors) AND empty($search)) {
    	// update this data in the database
        $dblink->startTransaction();
        $save_pageno = $dblink->pageno;
        $link_data = $dblink->updateLinkData($link_data, $_POST);
        $dblink->pageno = $save_pageno;
        if ($dblink->errors) {
            $dblink->rollback();
    		// errors are keyed by object name
            $errors[$dblink->getClassName()] = $dblink->getErrors();
        } else {
            // update was OK
            $dblink->wf_case_id     = $dbouter->wf_case_id;
            $dblink->wf_workitem_id = $dbouter->wf_workitem_id;
            $dblink->wf_context     = $dbouter->wf_context;
            $errors = $dblink->commit();
            if (empty($errors)) {
                $messages[] = getLanguageText('sys0091'); // 'Update successful'
            } // if
            // where do we go from here?
            $curitem  = $scrolling[$dbouter->getClassName()]['curitem'];
            $lastitem = $scrolling[$dbouter->getClassName()]['lastitem'];
            if (isset($_POST['submitnext'])) {
                // skip to the next item (if there is one)
                if ($curitem < $lastitem) {
                    $curitem++;
                    $scrolling[$dbouter->getClassName()]['curitem'] = $curitem;
                    $dbouter->setPageNo($curitem);
                    $where = $scrolling[$dbouter->getClassName()]['where'];
                } elseif ($curitem == 1 AND $lastitem == 1 AND $dblink->pageno < $dblink->lastpage) {
                    // skip to next page of inner entity
                    $dblink->setPageNo($dblink->pageno+1);
                } else {
                    // no more items, so return to previous screen
                    scriptPrevious($errors, $messages, 'OK', $dbouter->getInstruction());
                } // if
            } elseif (isset($_POST['submitstay'])) {
                // remain in this screen
            } else {
                // SUBMIT presed
                if ($dblink->pageno < $dblink->lastpage) {
                	// skip to next page of inner entity
                    $dblink->setPageNo($dblink->pageno+1);
                } else {
                	// retun to previous screen
                	scriptPrevious($errors, $messages, 'OK', $dbouter->getInstruction());
                } // if
            } // if
            // re-read database in case any values have changed
            $fieldarray = $dbouter->getData($where);
            if ($dbouter->numrows == 0) {
                // record cannot be found, so re-read using original $where clause
                $where      = $scrolling[$dbouter->getClassName()]['where'];
                $fieldarray = $dbouter->getData($where);
            } // if
            // reset 'lastitem' in scroll array
            $scrolling[$dbouter->getClassName()]['lastitem'] = $dbouter->getLastPage();
            $script_vars['scrolling'] = $scrolling;
            // get any extra data and merge with $fieldarray
            $fieldarray = $dbouter->getExtraData($fieldarray);
            if ($dbouter->errors) {
            	// errors are keyed by object name
                $errors[$dbouter->getClassName()] = $dbouter->getErrors();
            } // if
            // rebuild selection criteria using primary key of current occurrence
            $where = array2where($fieldarray, $dbouter->getPkeyNames(), $dbouter);
        } // if
    } // if
} // if

// check if we are returning from a child form
if (!empty($return_from) AND !empty($popup_object)) {
    if (isset($selection) AND $popup_object == 'dbouter') {
        // merge previous saved variables with selection from popup form
        $outer_data = $dbouter->popupReturn($outer_data, basename($return_from), $selection);
        if ($dbouter->errors) {
        	$errors[$dbouter->getClassName()] = $dbouter->getErrors();
        } // if
    } // if
} else {
    if (isset($scrolling)) {
        if ($new_selection === true) {
        	// selection has changed, so use new value in $where
        	$dbouter->setPageNo(1);
        } else {
            // retrieve values from scrolling array
            $where = $scrolling[$dbouter->getClassName()]['where'];
            if (isset($_GET['scrolling']) AND $_GET['scrolling'] == $dbouter->getClassName()) {
                // set index number of item to be read from current $where list
                $dbouter->setPageNo($_GET['item']);
            } else {
                // stay on current item
                $dbouter->setPageNo($scrolling[$dbouter->getClassName()]['curitem']);
            } // if
        } // if
    } // if

    if (empty($where)) {
        scriptPrevious(getLanguageText('sys0082')); // 'No parent has been selected yet.'
    } // if

    // get data from the outer table
    $outer_data = $dbouter->getData($where);

    if ($dbouter->errors) {
        // some sort of error - return to previous script
        scriptprevious($dbouter->getErrors(), $messages);
    } // if
    if ($dbouter->getNumRows() < 1) {
        scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
    } // if

    // get any extra data and merge with $outer_data
    $outer_data = $dbouter->getExtraData($outer_data);

    // set variables to be included in XML output
    $scrolling[$dbouter->getClassName()]['curitem']  = $dbouter->getPageNo();
    $scrolling[$dbouter->getClassName()]['lastitem'] = $dbouter->getLastPage();
    $scrolling[$dbouter->getClassName()]['where']    = $where;
} // if

if (isset($_SESSION['rowsperpage'])) {
    $dblink->setRowsPerPage($_SESSION['rowsperpage']);
} // if

if (isset($_GET['pagesize'])) {
    $dblink->setRowsPerPage($_GET['pagesize']);
    $_SESSION['rowsperpage'] = $_GET['pagesize'];
} // if

// obtain the required page number (optional)
if (isset($_GET['page'])) {
    $dblink->setPageNo($_GET['page']);
} // if

// obtain the 'orderby' field (optional)
if (isset($_GET['orderby'])) {
    $string = validateSortItem('link', $_GET['orderby'], $dblink, $screen_structure);
    $dblink->setOrderBy($string, $dblink->sql_orderby_seq);
} // if

// load optional criteria from search screen
if (isset($search)) {
    $dblink->setSqlSearch($search, true);
} // if

// get primary key of current row retrieved from OUTER entity
$pkeynames = $dbouter->getPkeyNamesAdjusted();
$where = array2where($outer_data, $pkeynames, $dbouter);

// ensure that column names are qualified in the 'where' clause
$link_where = qualifyWhere($where, $dbouter->tablename, $dbouter->getFieldSpec());

if (isset($_POST['reset'])) {
    // initialise all settings to start afresh
    $dblink->reset($link_where);
} // if

if (count($outer_data) > 0) {
    // check if we are returning from a child form
    if (!empty($return_from) AND !empty($popup_object)) {
        if (isset($selection) AND $popup_object == 'dblink') {
            // merge previous saved variables with selection from popup form
            $link_data = $dblink->popupReturn($link_data, basename($return_from), $selection, $popup_offset);
            if ($dblink->errors) {
            	$errors[$dblink->getClassName()] = $dblink->getErrors();
            } // if
        } // if
    } else {
        // get data from the database
        $link_data = $dblink->getData($link_where);

        if ($dblink->errors) {
            $errors[$dblink->getClassName()] = $dblink->getErrors();
        } // if

        if ($dblink->getNumRows() == 0) {
            $errors[] = getLanguageText('sys0088', $link_table); // "No entries found on $link_table"
            unset($act_buttons['submit']);
            unset($act_buttons['submitstay']);
            unset($act_buttons['submitnext']);
        } // if

        // get any extra data (such as lookup lists)
        $link_data = $dblink->getExtraData($link_data);
    } // if
} // if

if (isset($_GET['action'])) {
    $link_data = $dblink->setAction($_GET['action']);
} // if

// get pagination details
$pagination['link']['numrows']  = $dblink->getNumRows();
$pagination['link']['curpage']  = $dblink->getPageNo();
$pagination['link']['lastpage'] = $dblink->getLastPage();

// get sort details
//$orderby     = $dblink->getOrderBy();
//$orderby_seq = $dblink->getOrderBySeq($orderby);

// save these variables for later in the same session
$script_vars['where']     = $where;
$script_vars['dbouter']   = serialize($dbouter);
$script_vars['dblink']    = serialize($dblink);
$script_vars['scrolling'] = $scrolling;
$script_vars = updateScriptVars ($script_vars);

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbouter;
$xml_objects[][$dbouter->getClassName()] = &$dblink;

// build XML document and perform XSL transformation
$view = new radicore_view($screen_structure);
$view->buildXML($xml_objects, $errors, $messages);
exit;

?>
