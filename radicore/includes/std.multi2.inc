<?php
// *****************************************************************************
// Copyright 2003-2006 by A J Marston <http://www.tonymarston.net>
// Licensed to Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.multi2.inc

// type = multi2

// This will display data from 2 tables in a ONE-to-MANY relationship.
// (also known as a PARENT-CHILD or OUTER-INNER retaltionship).
// It will start by reading the OUTER entity using the primary key passed down
// from the previous screen, then show existing occurrences of INNER.
// Occurrences of INNER may then be modified, or added and deleted using the
// relevant buttons on the navigation bar.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'update';

// load session variables
initSession();

if (isset($_POST['quit'])) {
    // clear this script from session details and return to previous page
    scriptPrevious(null, null, 'quit');
} // if

// define action buttons
$act_buttons['reset']      = 'reset';
$act_buttons['submit']     = 'submit';
$act_buttons['submitnext'] = 'submitnext';
$act_buttons['quit']       = 'cancel';

// create a class instance for the OUTER database table
require_once "classes/$outer_table.class.inc";
if (isset($script_vars['dbouter'])) {
    // use data from previous instance of this script
    $dbouter = unserialize($script_vars['dbouter']);
    // get previously retrieved data
    $outer_data = $dbouter->getFieldArray();
} else {
    // create new instance for initial activation of this script
    $dbouter = new $outer_table;
    $dbouter->sql_select     = &$outer_sql_select;
    $dbouter->sql_from       = &$outer_sql_from;
    $dbouter->sql_where      = &$outer_sql_where;
    $dbouter->sql_groupby    = &$outer_sql_groupby;
    $dbouter->sql_having     = &$outer_sql_having;
    $dbouter->sql_sort_table = &$outer_sql_sort_table;
    if (!empty($outer_sql_orderby)) {
        $dbouter->setDefaultOrderby($outer_sql_orderby);
    } //if
    // set this object to 'noedit'
    $dbouter->xsl_params = array('outer_noedit' => 'y');
    // check that primary key is complete
    $dbouter->checkPrimaryKey = true;
    // scroll through one item at a time
    $dbouter->setRowsPerPage(1);
    // set sort order (if defined)
    if (!empty($order_by)) {
        $string = validateSortItem('outer', $order_by, $dbouter, $screen_structure);
        $dbouter->setOrderBy($string);
        if (!empty($order_by_seq)) {
            $dbouter->setOrderBySeq($order_by_seq);
        } // if
    } // if
    if (isset($outer_sql_where) and strlen($outer_sql_where) > 0) {
        // merge two strings into one
    	$where = mergeWhere($where, $outer_sql_where);
    	$dbouter->sql_where = null;
    } // if
    // perform any initialisation
    $where = $dbouter->initialise($where, $selection);
} // if

// create a class instance for the INNER database table
require_once "classes/$inner_table.class.inc";
if (isset($script_vars['dbinner'])) {
    // use data from previous instance of this script
    $dbinner = unserialize($script_vars['dbinner']);
    // get previously retrieved data
    $inner_data = $dbinner->getFieldArray();
} else {
    $dbinner = new $inner_table;
    $dbinner->sql_select       = &$inner_sql_select;
    $dbinner->sql_from         = &$inner_sql_from;
    $dbinner->sql_where        = &$inner_sql_where;
    $dbinner->sql_groupby      = &$inner_sql_groupby;
    $dbinner->sql_having       = &$inner_sql_having;
    $dbinner->sql_search_table = &$inner_search_table;
    if (!empty($inner_sql_orderby)) {
        $dbinner->setDefaultOrderby($inner_sql_orderby);
    } elseif (!empty($task_order_by)) {
        $dbinner->setDefaultOrderby($task_order_by);
    } // if
    // perform any initialisation
    $where = $dbinner->initialise($where, $selection);
} // if

if (!empty($_POST)) {
    // look for an action which is another script
    $errors = childForm($_POST, $dbinner, 'dbinner', $where);
} // if

// look for entered data
if (isset($_POST['submit']) or isset($_POST['submitnext'])) {
    // retrieve current data
    $inner_data = $dbinner->getFieldArray();
    // update database with changes in POST array
    $dbinner->startTransaction();
    $inner_data = $dbinner->updateMultiple($inner_data, $_POST);
    if ($dbinner->errors) {
        $dbinner->rollback();
		// errors are keyed by object name
        $errors[$dbinner->getClassName()] = $dbinner->getErrors();
    } else {
        // update was OK
        $errors = $dbinner->commit();
        if ($errors) {
        	$dbobject->rollback();
        } else {
            $messages[] = getLanguageText('sys0091'); // 'Update successful'
        } // if
        if (isset($_POST['submitnext'])) {
            $curitem  = $scrolling[$dbouter->getClassName()]['curitem'];
            $lastitem = $scrolling[$dbouter->getClassName()]['lastitem'];
            if ($curitem < $lastitem) {
                // skip to the next item
                $curitem++;
                $scrolling[$dbouter->getClassName()]['curitem'] = $curitem;
                $dbouter->setPageNo($curitem);
                $where = $scrolling[$dbouter->getClassName()]['where'];
                $outer_data = $dbouter->getData($where);
                $scrolling[$dbouter->getClassName()]['lastitem'] = $dbouter->getLastPage();
                $script_vars['scrolling'] = $scrolling;
            } else {
                // update was OK - return to previous screen
                scriptPrevious($errors, $messages, 'OK', $dbinner->getInstruction());
            } // if
        } // if
    } // if
} // if

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    if (!empty($selection)) {
        // retrieve profile has been passed down from previous screen
        $where = $selection;
        $selection = null;
    } else {
        if (isset($scrolling)) {
            // retrieve values from scrolling array
            $where = $scrolling[$dbouter->getClassName()]['where'];
            $dbouter->setPageNo($scrolling[$dbouter->getClassName()]['curitem']);
        } // if
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

    // get data from the outer table
    $outer_data = $dbouter->getData($where);
    if ($dbouter->errors) {
        // some sort of error
        if ($dbouter->getLastPage() <= 1) {
            // only 1 entry requested, so return to previous script
            scriptprevious($dbouter->getErrors(), $messages);
        } else {
            // multiple entries requested, so disable SUBMIT button
            unset($act_buttons['submit']);
            $errors = $dbouter->getErrors();
        } // if
    } // if
    if ($dbouter->getNumRows() < 1) {
        scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
    } // if

    // get any additional data for the current record
    $outer_data = $dbouter->getExtraData($outer_data);

    // set variables to be included in XML output
    $scrolling[$dbouter->getClassName()]['curitem']  = $dbouter->getPageNo();
    $scrolling[$dbouter->getClassName()]['lastitem'] = $dbouter->getLastPage();
    $scrolling[$dbouter->getClassName()]['where']    = $where;
} // if

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

if (isset($_POST['reset'])) {
    // initialise all settings to start afresh
    $dbinner->reset();
} // if

// get primary key of row retrieved from OUTER entity
$where = array2where($outer_data, $dbouter->getPkeyNames(), $dbouter);

// ensure that column names are qualified in the 'where' clause
$inner_where = qualifyWhere($where, $dbouter->tablename, $dbouter->getFieldSpec());

// load in current data from $outer in case it is needed
$dbinner->setFieldArray($outer_data);

// obtain the required page number (optional)
if (isset($_GET['page'])) {
    $dbinner->setPageNo($_GET['page']);
} // if

// if ($_SERVER['REQUEST_METHOD'] == 'GET' OR isset($_POST['reset'])) {
if (empty($errors)) {
    // get data from the database
    $inner_data = $dbinner->getData($inner_where);

    $errors = $dbinner->getErrors();

    if ($dbinner->getNumRows() == 0) {
        $errors[] = getLanguageText('sys0088', strtoupper($inner_table)); // 'No entries found on $inner_table'
        unset($act_buttons['submit']);
    } // if

    // $where may have been changed in database object
    $where = $dbinner->getWhere();
} // if

// get any additional data for current record
$inner_data = $dbinner->getExtraData($inner_data);

if (isset($_GET['action'])) {
    $inner_data = $dbinner->setAction($_GET['action']);
} // if

// get pagination details
$pagination['inner']['numrows']  = $dbinner->getNumRows();
$pagination['inner']['curpage']  = $dbinner->getPageNo();
$pagination['inner']['lastpage'] = $dbinner->getLastPage();

// ensure script variables are available throughout this session
unset($script_vars['selection']);
$script_vars['where']     = unqualifyWhere($where);
$script_vars['dbouter']   = serialize($dbouter);
$script_vars['dbinner']   = serialize($dbinner);
$script_vars['scrolling'] = $scrolling;
$PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'
$_SESSION[$PHP_SELF][$task_id] = $script_vars;

// get sort details
$orderby     = $dbinner->getOrderBy();
$orderby_seq = $dbinner->getOrderBySeq();

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbouter;
$xml_objects[][$dbouter->getClassName()] = &$dbinner;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);
exit;

?>
