<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
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
    $dbouter->sql_select  = &$outer_sql_select;
    $dbouter->sql_from    = &$outer_sql_from;
    $dbouter->sql_where   = &$outer_sql_where;
    $dbouter->sql_groupby = &$outer_sql_groupby;
    $dbouter->sql_having  = &$outer_sql_having;
    if (!empty($outer_sql_orderby)) {
        $dbouter->setDefaultOrderby($outer_sql_orderby);
    } elseif (!empty($order_by)) {
        $dbouter->setOrderby($order_by);
        if (!empty($order_by_seq)) {
            $dbouter->setOrderBySeq($order_by_seq);
        } // if
    } // if
    // check that primary key is complete
    $dbouter->checkPrimaryKey = true;
    // scroll through one item at a time
    $dbouter->setRowsPerPage(1);
    // perform any initialisation
    $where = $dbouter->initialise($where, $selection);
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
    $dbmiddle->sql_select  = &$middle_sql_select;
    $dbmiddle->sql_from    = &$middle_sql_from;
    $dbmiddle->sql_where   = &$middle_sql_where;
    $dbmiddle->sql_groupby = &$middle_sql_groupby;
    $dbmiddle->sql_having  = &$middle_sql_having;
    // scroll through one item at a time
    $dbmiddle->setRowsPerPage(1);
    // perform any initialisation
    $where = $dbmiddle->initialise($where, $selection);
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
    $dbinner->sql_select       = &$inner_sql_select;
    $dbinner->sql_from         = &$inner_sql_from;
    $dbinner->sql_where        = &$inner_sql_where;
    $dbinner->sql_groupby      = &$inner_sql_groupby;
    $dbinner->sql_having       = &$inner_sql_having;
    $dbinner->sql_search_table = &$inner_search_table;
    if (!empty($order_by_body)) {
        $dbinner->setDefaultOrderby($order_by_body);
    } // if
    // perform any initialisation
    $where = $dbinner->initialise($where, $selection);
} // if

if (!empty($_POST)) {
    // look for an action which is another script
    $errors = childForm($_POST, $dbinner, 'dbinner', $where);
} // if

// look for entered data
if (isset($_POST['submit'])) {
    // retrieve current data
    $inner_data = $dbinner->getFieldArray();
    // update database with changes in POST array
    $dbinner->startTransaction();
    $inner_data = $dbinner->updateMultiple($inner_data, $_POST);
    if ($dbinner->getErrors()) {
        $dbinner->rollback();
		// errors are keyed by object name
        $errors[$dbinner->getClassName()] = $dbinner->getErrors();
    } else {
        // update was OK
        $errors = $dbinner->commit();
        if (empty($errors)) {
            $messages[] = getLanguageText('sys0091'); // 'Update successful'
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

if (isset($_POST['reset'])) {
    // initialise all settings to start afresh
    $dbouter->setSqlSearch(null);
    $dbouter->setPageNo(1);
    $dbmiddle->setPageNo(1);
} // if

// get data from the outer table
$outer_data = $dbouter->getData($where);
if ($dbouter->getErrors()) {
    // some sort of error
    if ($dbouter->getLastPage() <= 1) {
        // only 1 entry requested, so return to previous script
        scriptprevious($dbouter->getErrors(), $messages);
    } else {
        // multiple entries requested, so display error message
        $errors = $dbouter->getErrors();
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

// get primary key of 1st row retrieved from OUTER entity
$where = array2where($outer_data, $dbouter->getPkeyNames(), $dbouter);

// load in current data from $outer in case it is needed
$dbmiddle->setFieldArray($outer_data);

if (isset($_GET['scrolling']) AND $_GET['scrolling'] == $dbmiddle->getClassName()) {
    // set index number of item to be read from current $where list
    $dbmiddle->setPageNo($_GET['item']);
} // if

// get data from the middle table
$middle_data = $dbmiddle->getData($where);
if ($dbmiddle->getErrors()) {
    // errors are keyed by object name
    $errors[$dbmiddle->getClassName()] = $dbmiddle->getErrors();
} // if
if ($dbmiddle->getNumRows() < 1) {
    // scriptPrevious('Nothing retrieved from the database.');
    $errors[] = getLanguageText('sys0088', strtoupper($dbmiddle->getClassName())); // 'No entries found on $dbmiddle'
    unset($act_buttons['submit']);
} // if

// get any additional data for current record
$middle_data = $dbmiddle->getExtraData($middle_data);

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
    if (isset($screen)) {
    	if (validateSortItem('inner', $_GET['orderby'], $screen)) {
        	$dbinner->setOrderBy($_GET['orderby']);
        } // if
    } else {
        $dbinner->setOrderBy($_GET['orderby']);
    } // if
} // if

// load optional criteria from search screen
if (isset($search)) {
    $dbinner->setSqlSearch($search);
} // if

if (isset($_POST['reset'])) {
    // initialise all settings to start afresh
    $dbinner->setPageNo(null);
    $dbinner->setOrderBy(null);
    $dbinner->setOrderBySeq(null);
    $dbinner->setSqlSearch(null);
} // if

if (isset($instruction)) {
    // load instruction returned by a child script
    $dbinner->setInstruction($instruction);
} // if

// merge OUTER and MIDDLE where to get selection criteria for INNER
$inner_where = mergeWhere($where, $middle_where);

// load in current data from $middle in case it is needed
$dbinner->setFieldArray($middle_data);

// obtain the required page number (optional)
if (isset($_GET['page'])) {
    $dbinner->setPageNo($_GET['page']);
} // if

// if ($_SERVER['REQUEST_METHOD'] == 'GET' OR isset($_POST['reset'])) {
if (empty($errors)) {
    // get data from the database
    $inner_data = $dbinner->getData($inner_where);
    if ($dbinner->getErrors()) {
        $errors[$dbinner->getClassName()] = $dbinner->getErrors();
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
} // if

if (isset($_GET['action'])) {
    $inner_data = $dbinner->setAction($_GET['action']);
} // if

// $where may have been changed in database object
$where = $dbinner->getWhere();

// get pagination details
$pagination['inner']['numrows']  = $dbinner->getNumRows();
$pagination['inner']['curpage']  = $dbinner->getPageNo();
$pagination['inner']['lastpage'] = $dbinner->getLastPage();

// ensure script variables are available throughout this session
unset($script_vars['selection']);
$script_vars['where']     = $where;
$script_vars['dbouter']   = serialize($dbouter);
$script_vars['dbmiddle']  = serialize($dbmiddle);
$script_vars['dbinner']   = serialize($dbinner);
$script_vars['scrolling'] = $scrolling;
$PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'
$_SESSION[$PHP_SELF][$task_id] = $script_vars;

// get sort details
$orderby     = $dbinner->getOrderBy();
$orderby_seq = $dbinner->getOrderBySeq();

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbouter;
$xml_objects[][$dbouter->getClassName()]  = &$dbmiddle;
$xml_objects[][$dbmiddle->getClassName()] = &$dbinner;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);
exit;

?>
