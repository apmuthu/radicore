<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2007 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.multi3.inc

// type = multi3

// This will allow multiple occurrences of INNER in a OUTER-to-MIDDLE-to-INNER
// relationship to be maintained, where:
// OUTER-to-MIDDLE is ONE-to-MANY and
// INNER-to-MIDDLE is ONE-to-MANY.
// In other words this is a ONE-to-MANY-to-ONE relationship.
// The OUTER entity can be swapped with the INNER entity and this function will
// still work.
// The primary key of the OUTER entity will be passed down from the previous
// screen in $where.
// The remaining ONE entity will be designated as INNER. It will start by displaying
// the first available row, with hyperlinks to scroll forwards and backwards.
// The primary key of the OUTER and current INNER entties will be used to fetch
// records from the MANY entity.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'update';

// load session variables
initSession();

if (!empty($selection) AND !isset($return_from)) {
	// $selection takes precedence over $where
    $where     = $selection;
    $selection = null;
} // if

if (isset($_POST['quit'])) {
    // clear this script from session details and return to previous page
    scriptPrevious(null, null, 'quit');
} // if

// define action buttons
$act_buttons['reset']  = 'reset';
$act_buttons['submit'] = 'submit';
$act_buttons['quit']   = 'cancel';

// create a class instance for the OUTER database table
require_once "classes/$outer_table.class.inc";
if (isset($script_vars['dbouter'])) {
    // use previous instance from session data
    $dbouter = unserialize($script_vars['dbouter']);
    // get data from previous instance
    $outer_data = $dbouter->getFieldArray();
} else {
    // create new instance for initial activation of this script
    $dbouter = new $outer_table;
    // indicate that this object was started from a page controller
    $dbouter->initiated_from_controller = true;
    $dbouter->sql_select     = &$outer_sql_select;
    $dbouter->sql_from       = &$outer_sql_from;
    $dbouter->sql_where      = &$outer_sql_where;
    $dbouter->sql_groupby    = &$outer_sql_groupby;
    $dbouter->sql_having     = &$outer_sql_having;
    $dbouter->sql_orderby_table = &$outer_sql_orderby_table;
    if (!empty($outer_sql_orderby)) {
        $dbouter->setDefaultOrderby($outer_sql_orderby);
    } // if
    // scroll through one item at a time
    $dbouter->setRowsPerPage(1);
    // check that primary key is complete
    $dbouter->checkPrimaryKey = true;
    // perform any initialisation
    $where = $dbouter->initialise($where);
    if ($dbouter->errors) {
        scriptPrevious($dbouter->errors);
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

// create a class instance for the MIDDLE database table
require_once "classes/$middle_table.class.inc";
if (isset($script_vars['dbmiddle'])) {
    // use previous instance from session data
    $dbmiddle = unserialize($script_vars['dbmiddle']);
    // get previously retrieved data
    $middle_data = $dbmiddle->getFieldArray();
} else {
    // create new instance for initial activation of this script
    $dbmiddle = new $middle_table;
    // indicate that this object was started from a page controller
    $dbmiddle->initiated_from_controller = true;
    $dbmiddle->sql_select  = &$middle_sql_select;
    $dbmiddle->sql_from    = &$middle_sql_from;
    $dbmiddle->sql_where   = &$middle_sql_where;
    $dbmiddle->sql_groupby = &$middle_sql_groupby;
    $dbmiddle->sql_having  = &$middle_sql_having;
    if (!empty($middle_sql_orderby)) {
        $dbmiddle->setDefaultOrderby($middle_sql_orderby);
    } // if
    // scroll through one item at a time
    $dbmiddle->setRowsPerPage(1);
    // perform any initialisation
    $null = $dbmiddle->initialise($where);
    if ($dbmiddle->errors) {
        scriptPrevious($dbmiddle->errors);
    } // if
} // if

// create a class instance for the INNER database table
require_once "classes/$inner_table.class.inc";
if (isset($script_vars['dbinner'])) {
    // use data from previous instance of this script
    $dbinner = unserialize($script_vars['dbinner']);
    // get previously retrieved data
    $inner_data = $dbinner->getFieldArray();
} else {
    // create new instance for initial activation of this script
    $dbinner = new $inner_table;
    // indicate that this object was started from a page controller
    $dbinner->initiated_from_controller = true;
    $dbinner->sql_select       = &$inner_sql_select;
    $dbinner->sql_from         = &$inner_sql_from;
    $dbinner->sql_where        = &$inner_sql_where;
    $dbinner->sql_groupby      = &$inner_sql_groupby;
    $dbinner->sql_having       = &$inner_sql_having;
    $dbinner->sql_search_table = &$inner_search_table;
    if (!empty($inner_sql_orderby)) {
        $dbinner->setDefaultOrderby($inner_sql_orderby);
    } elseif (!empty($task_orderby)) {
        $dbinner->setDefaultOrderby($task_orderby);
    } // if
    // perform any initialisation
    $null = $dbinner->initialise($where);
    if ($dbinner->errors) {
        scriptPrevious($dbinner->errors);
    } // if
} // if

if (!empty($_POST)) {
    // merge original data with POSTed data (so that fields which were displayed
    // but not POSTed are sent back if any errors are displayed).
    $inner_post = getPostArray($_POST, $dbinner->getFieldSpec());
    $inner_data = array_update_indexed($inner_data, $inner_post);
    $dbinner->setFieldArray($inner_data);
    // look for an action which is another script
    $errors = childForm($_POST, array('dbmiddle' => $dbmiddle, 'dbinner' => $dbinner));
} // if

// look for entered data
if (isset($_POST['submit'])) {
    // update database with changes in POST array
    $dbinner->startTransaction();
    $inner_data = $dbinner->updateMultiple($inner_data, $_POST);
    if ($dbinner->errors) {
        $dbinner->rollback();
		// errors are keyed by object name
        $errors[$dbinner->getClassName()] = $dbinner->errors;
    } else {
        // update was OK
        $dbinner->wf_case_id     = $dbouter->wf_case_id;
        $dbinner->wf_workitem_id = $dbouter->wf_workitem_id;
        $dbinner->wf_context     = $dbouter->wf_context;
        $errors = $dbinner->commit();
        if (empty($errors)) {
            $messages[] = getLanguageText('sys0091'); // 'Update successful'
        } // if
    } // if
} // if

if (isset($scrolling)) {
    // retrieve values from scrolling array
    $where = $scrolling[$dbouter->getClassName()]['where'];
    $dbouter->setPageNo($scrolling[$dbouter->getClassName()]['curitem']);
} // if
if (empty($where)) {
    if ($dbouter->allow_empty_where == TRUE) {
        // this class is allowed to read multiple records
        if (isset($search)) {
            // load in any search criteria
            $dbouter->setSqlSearch($search);
        } // if
    } else {
        scriptPrevious(getLanguageText('sys0082')); // 'No parent has been selected yet.'
    } // if
} // if

if (isset($_GET['scrolling']) AND $_GET['scrolling'] == $dbouter->getClassName()) {
    // set index number of item to be read from current $where list
    $dbouter->setPageNo($_GET['item']);
} // if

if (isset($_POST['reset'])) {
    // initialise all settings to start afresh
    $dbouter->reset($where);
} // if

// get data from the outer table
$outer_data = $dbouter->getData($where);
if ($dbouter->errors) {
    // some sort of error
    if ($dbouter->getLastPage() <= 1) {
        // only 1 entry requested, so return to previous script
        scriptprevious($dbouter->errors, $messages);
    } else {
        // multiple entries requested, so display error message
        $errors[$dbouter->getClassName()] = $dbouter->errors;
    } // if
} // if
$messages = array_merge($messages, $dbouter->getMessages());
if ($dbouter->getNumRows() < 1) {
    scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
} // if

// set variables to be included in XML output
$scrolling[$dbouter->getClassName()]['curitem']  = $dbouter->getPageNo();
$scrolling[$dbouter->getClassName()]['lastitem'] = $dbouter->getLastPage();
$scrolling[$dbouter->getClassName()]['where']    = $where;

// get any additional data for current record
$outer_data = $dbouter->getExtraData($outer_data);
if ($dbouter->errors) {
	$errors[$dbouter->getClassName()] = $dbouter->errors;
} // if

if (isset($_GET['scrolling']) AND $_GET['scrolling'] == $dbmiddle->getClassName()) {
    // set index number of item to be read from current $where list
    $dbmiddle->setPageNo($_GET['item']);
} // if

// load in current data from $outer in case it is needed
$dbmiddle->setFieldArray($outer_data);

// get primary key of 1st row retrieved from OUTER entity
$where = array2where($outer_data, $dbouter->getPkeyNames(), $dbouter);

if (isset($_POST['reset'])) {
    // initialise all settings to start afresh
    $dbmiddle->reset($where);
} // if

if (isset($search)) {
    $dbmiddle->setSqlSearch($search);
} // if

// get data from the middle table
$middle_data = $dbmiddle->getData($where);
if ($dbmiddle->errors) {
    // errors are keyed by object name
    $errors[$dbmiddle->getClassName()] = $dbmiddle->errors;
} // if
if ($dbmiddle->getNumRows() < 1) {
    // scriptPrevious('Nothing retrieved from the database.');
    $errors[] = getLanguageText('sys0088', strtoupper($dbmiddle->getClassName())); // 'No entries found on $dbmiddle'
    unset($act_buttons['submit']);
} // if

// get any additional data for current record
$middle_data = $dbmiddle->getExtraData($middle_data);
if ($dbmiddle->errors) {
	$errors[$dbmiddle->getClassName()] = $dbmiddle->errors;
} // if

// get primary key of row retrieved from middle entity
$middle_where = array2where($middle_data, $dbmiddle->getPkeyNames(), $dbmiddle);

// set variables to be included in XML output
$scrolling[$dbmiddle->getClassName()]['curitem']  = $dbmiddle->getPageNo();
$scrolling[$dbmiddle->getClassName()]['lastitem'] = $dbmiddle->getLastPage();
$scrolling[$dbmiddle->getClassName()]['where']    = $middle_where;

if (isset($_SESSION['rowsperpage'])) {
    $dbinner->setRowsPerPage($_SESSION['rowsperpage']);
} // if

if (isset($_GET['pagesize'])) {
    $dbinner->setRowsPerPage($_GET['pagesize']);
    $_SESSION['rowsperpage'] = $_GET['pagesize'];
} // if

// obtain the 'orderby' field (optional)
if (isset($_GET['orderby'])) {
    $string = validateSortItem('inner', $_GET['orderby'], $dbinner, $screen_structure);
    $dbinner->setOrderBy($string);
} // if

// load optional criteria from search screen
if (isset($search)) {
    $dbinner->setSqlSearch($search);
} // if

if (isset($instruction)) {
    // load instruction returned by a child script
    $dbinner->setInstruction($instruction);
} // if

// obtain the required page number (optional)
if (isset($_GET['page'])) {
    $dbinner->setPageNo($_GET['page']);
} // if

// merge OUTER and MIDDLE where to get selection criteria for INNER
$inner_where = mergeWhere($where, $middle_where);

if (isset($_POST['reset'])) {
    // initialise all settings to start afresh
    $dbinner->reset($inner_where);
} // if

// only read INNER if MIDDLE is not empty
if (count($middle_data) > 0) {
    if (!empty($return_from) AND !empty($popup_object)) {
        if (isset($selection) AND $popup_object == 'dbinner') {
            $inner_data = $dbinner->popupReturn($inner_data, basename($return_from), $selection, $popup_offset);
        } //if
    } else {
        // load in current data from $middle in case it is needed
        $dbinner->setFieldArray($middle_data);

        // get data from the database
        $inner_data = $dbinner->getData($inner_where);
        if ($dbinner->errors) {
            $errors[$dbinner->getClassName()] = $dbinner->errors;
        } // if

        if ($dbinner->getNumRows() == 0) {
            if (!is_array($errors)) {
                $errors = (array)$errors;
            } // if
            $errors[] = getLanguageText('sys0088', strtoupper($inner_table)); // 'No entries found on $inner_table'
            unset($act_buttons['submit']);
        } // if

        // get any additional data for current record
        $inner_data = $dbinner->getExtraData($inner_data);
        if ($dbinner->errors) {
        	$errors[$dbinner->getClassName()] = $dbinner->errors;
        } // if
    } // if
} // if

if (isset($_GET['action'])) {
    $inner_data = $dbinner->setAction($_GET['action']);
} // if

// get pagination details
$pagination['inner']['numrows']  = $dbinner->getNumRows();
$pagination['inner']['curpage']  = $dbinner->getPageNo();
$pagination['inner']['lastpage'] = $dbinner->getLastPage();

// save these variables for later in the same session
$script_vars['where']     = $where;
$script_vars['dbouter']   = serialize($dbouter);
$script_vars['dbmiddle']  = serialize($dbmiddle);
$script_vars['dbinner']   = serialize($dbinner);
$script_vars['scrolling'] = $scrolling;
$script_vars = updateScriptVars ($script_vars);

// get sort details
$orderby     = $dbinner->getOrderBy_Out();
$orderby_seq = $dbinner->getOrderBySeq();

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbouter;
$xml_objects[][$dbouter->getClassName()]  = &$dbmiddle;
$xml_objects[][$dbmiddle->getClassName()] = &$dbinner;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);
exit;

?>
