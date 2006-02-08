<?php
// *****************************************************************************
// Copyright 2003-2006 by A J Marston <http://www.tonymarston.net>
// Licensed to Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.list3.inc

// type = list3

// This is for a ONE-to-MANY(1)-to-MANY(2) relationship.
// Also known as OUTER-to-MIDDLE-to-INNER.
// MANY(1)-to-MANY(2) is another ONE-to-MANY relationship
// The primary key of ONE (OUTER) will be passed in $where from the previous screen.
// This will then be passed to MIDDLE (MANY1) for processing.
// The primary key of MIDDLE will then be passed to INNER (MANY2).

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'list';

// load session variables
initSession();

if (isset($_POST['quit'])) {
    // the 'quit' button has been pressed, so ...
    // clear this script from session details and return to previous page
    if (isset($act_buttons) AND array_key_exists('choose', $act_buttons)) {
        scriptPrevious(getLanguageText('sys0083')); // 'Nothing selected from popup screen.'
    } else {
        scriptPrevious();
    } // if
} // if

// define action buttons
$act_buttons['reset'] = 'reset';
$act_buttons['quit']  = 'close';

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
    $dbouter->sql_select     = &$outer_sql_select;
    $dbouter->sql_from       = &$outer_sql_from;
    $dbouter->sql_where      = &$outer_sql_where;
    $dbouter->sql_groupby    = &$outer_sql_groupby;
    $dbouter->sql_having     = &$outer_sql_having;
    $dbouter->sql_sort_table = &$outer_sql_sort_table;
    if (!empty($outer_sql_orderby)) {
        $dbouter->setDefaultOrderby($outer_sql_orderby);
    } //if
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

// create a class instance for the MIDDLE database table
require_once "classes/$middle_table.class.inc";
if (isset($script_vars['dbmiddle'])) {
    // use previous instance from session data
    $dbmiddle = unserialize($script_vars['dbmiddle']);
    // get data from previous instance
    $middle_data = $dbmiddle->getFieldArray();
} else {
    // create new instance for initial activation of this script
    $dbmiddle = new $middle_table;
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
    $where = $dbmiddle->initialise($where, $selection);
} // if

// create a class instance for the INNER database table
require_once "classes/$inner_table.class.inc";
if (isset($script_vars['dbinner'])) {
    // use previous instance from session data
    $dbinner = unserialize($script_vars['dbinner']);
    // get data from previous instance
    $inner_data = $dbinner->getFieldArray();
    // refetch data for lookup lists in case they have changed
    $null = $dbinner->setLookupData(null);
} else {
    // create new instance for initial activation of this script
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

// the 'choose' button should only be available in popup screens
if (isset($_POST['choose'])) {
    $messages = chooseButton($_POST, $dbinner);
} // if

if (!empty($_POST)) {
    // look for an action which is another script
    $errors = childForm($_POST, $dbinner, 'dbinner', $where);
} // if

if (!empty($selection)) {
    // retrieve profile has been passed down from previous screen
    $where     = $selection;
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
    if (count($page_stack) > 2) {
        scriptPrevious(getLanguageText('sys0090', strtoupper($dbouter->getTableName()))); // 'Nothing retrieved from database table $outer'
    } else {
        $messages[] = getLanguageText('sys0090', strtoupper($dbouter->getTableName())); // 'Nothing retrieved from database table $outer'
    } // if
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
if ($dbmiddle->getNumRows() == 0) {
    $errors[] = getLanguageText('sys0088', strtoupper($middle_table)); // 'No entries found on $middle_table'
    if (array_key_exists('choose', $act_buttons)) {
        // this is unusable, so remove it
        unset($act_buttons['choose']);
    } // if
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

if (isset($instruction)) {
    // load instruction returned by a child script
    $dbinner->setInstruction($instruction);
} // if

// merge OUTER and MIDDLE where to get selection criteria for INNER
$inner_where = mergeWhere($where, $middle_where);

// obtain the required page number (optional)
if (isset($_GET['page'])) {
    $dbinner->setPageNo($_GET['page']);
} // if

if ($dbmiddle->numrows == 0) {
    $dbinner->setFieldArray(null);
    $inner_data = array();
} else {
    // load in current data from $middle in case it is needed
    $dbinner->setFieldArray($middle_data);
	// get data from the database
    $inner_data = $dbinner->getData($inner_where);
    if ($dbinner->getErrors()) {
        // errors are keyed by object name
        $errors[$dbinner->getClassName()] = $dbinner->getErrors();
    } // if
} // if
if ($dbinner->getNumRows() == 0) {
    $errors[] = getLanguageText('sys0088', strtoupper($inner_table)); // 'No entries found on $inner_table'
    if (strtolower($return_action) == 'search') {
        if (isset($return_from)) {
            $messages = $errors;
            // go back to script which generated this profile
            scriptNext($return_from);
        } // if
    } // if
    if (array_key_exists('choose', $act_buttons)) {
        // this is unusable, so remove it
        unset($act_buttons['choose']);
    } // if
} // if

// get any additional data for current record
$inner_data = $dbinner->getExtraData($inner_data);

if (isset($_GET['action'])) {
    $fieldarray = $dbinner->setAction($_GET['action']);
} // if

// $where may have been changed in database object
$where = $dbinner->getWhere();

// check for only one row being found in POPUP mode
if ($dbinner->getNumRows() == 1 AND isset($act_buttons['choose'])) {
    if (isset($choose_single_row)) {
        // convert primary key into SQL where format
        $selection = array2where($inner_data, $dbinner->getPkeyNames(), $dbinner);
        // send primary key back to the previous script
        $PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'
        $previous = $_SESSION[PHP_SELF]['previous'];
        $_SESSION[$previous]['selection'] = $selection;
        scriptPrevious(null, null, 'choose');
    } // if
} // if

// get pagination details
$pagination['inner']['numrows']  = $dbinner->getNumRows();
$pagination['inner']['curpage']  = $dbinner->getPageNo();
$pagination['inner']['lastpage'] = $dbinner->getLastPage();

// ensure script variables are available throughout this session
unset($script_vars['selection']);
$script_vars['where']     = unqualifyWhere($where);
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