<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2015 by Radicore Software Limited <http://www.radicore.org>
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

if (isset($act_buttons['choose'])) {
    if ($return_action == 'insert' AND !empty($selection)) {
    	// send selection back to the previous script
        $prev_script = getPreviousScript();
        $prev_task   = getPreviousTask($prev_script);
        $_SESSION['pages'][$prev_script][$prev_task]['selection'] = $selection;
        scriptPrevious(null, null, 'choose');
    } // if
} // if

$original_where     = $where;
$original_selection = $selection;
if (!empty($selection) AND !isset($return_from)) {
    // $selection takes precedence over $where
    //$where     = $selection;
    //$selection = null;
    $new_selection = true;
} else{
    $new_selection = false;
} // if

if (isset($_POST['quit'])) {
    // the 'quit' button has been pressed, so ...
    // clear this script from session details and return to previous page
    if (isset($act_buttons) AND array_key_exists('choose', $act_buttons)) {
        // 'Nothing selected from popup screen'
        scriptPrevious(getLanguageText('sys0083'),null,'quit');
    } else {
        scriptPrevious();
    } // if
} // if

// define action buttons
$act_buttons['reset'] = 'reset';
$act_buttons['quit']  = 'close';
if (array_key_exists('select_one', $settings)) {
	if (!is_True($settings['select_one'])) {
    	unset($act_buttons['choosenull']);
    } // if
} // if

// create a class instance for the OUTER database table
require_once "classes/$outer_table.class.inc";
if (isset($script_vars['dbouter'])) {
    // use previous instance from session data
    $dbouter = unserialize($script_vars['dbouter']);
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $dbouter->restart($return_from, $return_action, $return_string);
    } // if
    // get data from this instance
    $outer_data = $dbouter->getFieldArray();
    // redo any configuration changes
    $outer_data = $dbouter->getExtraData($outer_data);
} else {
    // create new instance for initial activation of this script
    $dbouter = new $outer_table;
    // indicate that this object was started from a page controller
    $dbouter->initiated_from_controller  = true;
    $dbouter->zone                       = 'outer';
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
    $where = $dbouter->initialise($original_where, $original_selection);
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
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $dbmiddle->restart($return_from, $return_action, $return_string);
    } // if
    // get data from previous instance
    $middle_data = $dbmiddle->getFieldArray();
    // redo any configuration changes
    $middle_data = $dbmiddle->getExtraData($middle_data);
} else {
    // create new instance for initial activation of this script
    $dbmiddle = new $middle_table;
    // indicate that this object was started from a page controller
    $dbmiddle->initiated_from_controller   = true;
    $dbmiddle->zone                        = 'middle';
    $dbmiddle->sql_select  = &$middle_sql_select;
    $dbmiddle->sql_from    = &$middle_sql_from;
    $dbmiddle->sql_where   = &$middle_sql_where;
    $dbmiddle->sql_groupby = &$middle_sql_groupby;
    $dbmiddle->sql_having  = &$middle_sql_having;
    if (!empty($task_selection)) {
        $dbmiddle->setSqlWhere($task_selection);
    } // if
    if (!empty($middle_sql_orderby)) {
        $dbmiddle->setDefaultOrderby($middle_sql_orderby);
    } elseif (!empty($task_orderby)) {
        $dbmiddle->setDefaultOrderby($task_orderby);
    } // if
    // scroll through one item at a time
    $dbmiddle->setRowsPerPage(1);
    $null = $dbmiddle->initialise($original_where, $original_selection);
} // if

// create a class instance for the INNER database table
require_once "classes/$inner_table.class.inc";
if (isset($script_vars['dbinner'])) {
    // use previous instance from session data
    $dbinner = unserialize($script_vars['dbinner']);
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $dbinner->restart($return_from, $return_action, $return_string);
    } // if
    // get data from previous instance
    $inner_data = $dbinner->getFieldArray();
    // redo any configuration changes
    $inner_data = $dbinner->getExtraData($inner_data);
} else {
    // create new instance for initial activation of this script
    $dbinner = new $inner_table;
    // indicate that this object was started from a page controller
    $dbinner->initiated_from_controller  = true;
    $dbinner->zone                       = 'inner';
    $dbinner->sql_select       = &$inner_sql_select;
    $dbinner->sql_from         = &$inner_sql_from;
    $dbinner->sql_where        = &$inner_sql_where;
    $dbinner->sql_groupby      = &$inner_sql_groupby;
    $dbinner->sql_having       = &$inner_sql_having;
    $dbinner->sql_search_table = &$inner_search_table;
    if (!empty($task_selection)) {
        $dbinner->setSqlWhere($task_selection);
    } // if
    if (!empty($inner_sql_orderby)) {
        $dbinner->setDefaultOrderby($inner_sql_orderby);
    } elseif (!empty($task_orderby)) {
        $dbinner->setDefaultOrderby($task_orderby);
    } // if
    $null = $dbinner->initialise($original_where, $original_selection);
} // if

// make each object available to its parent or child
$dbouter->setChildObject($dbmiddle);
$dbmiddle->setParentObject($dbouter);
$dbmiddle->setChildObject($dbinner);
$dbinner->setParentObject($dbmiddle);

// the 'choose' button should only be available in popup screens
if (isset($_POST['choose'])) {
    list($choose_errors, $messages) = chooseButton($_POST, $dbinner, 'dbinner');
    if (!empty($choose_errors)) {
        $errors[$dbinner->getClassName()] = $choose_errors;
    } // if
} // if

if (!empty($_POST)) {
    // look for an action which is another script
    $child_errors = childForm($_POST, array('dbmiddle' => &$dbmiddle, 'dbinner' => &$dbinner));
    if (is_array($child_errors)) {
        $errors = array_merge($errors, $child_errors);
    } // if
} // if

if (isset($_POST['reset'])) {
    // initialise all settings to start afresh
    $where = $dbouter->reset($where, true);  // but do not lose current ORDERBY settings
    $outer_data = $dbouter->getFieldArray();
    $where = $dbmiddle->reset($where);
    $middle_data = $dbmiddle->getFieldArray();
    $where = $dbinner->reset($where);
    $inner_data = $dbinner->getFieldArray();
} // if

if (isset($scrolling)) {
    if ($new_selection === true) {
    	// selection has changed, so use new value in $where
    	$dbouter->setPageNo(1);
    } else {
        // use previous values from scrolling array
        $where = $scrolling[$dbouter->getClassName()]['where'];
        if (isset($_GET['scrolling']) AND $_GET['scrolling'] == $dbouter->getClassName()) {
            // set index number of item to be read from current $where list
            $dbouter->setPageNo($_GET['item']);
        } // if
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

// get data from the outer table
$outer_data = $dbouter->getData($where);

if ($dbouter->errors) {
    // some sort of error
    if ($dbouter->getLastPage() <= 1) {
        // only 1 entry requested, so return to previous script
        scriptprevious($dbouter->getErrors(), $messages);
    } else {
        // multiple entries requested, so display error message
        $errors = $dbouter->getErrors();
    } // if
} // if

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

// get primary key of current row retrieved from OUTER entity
$pkeynames = $dbouter->getPkeyNamesAdjusted();
$where = array2where($outer_data, $pkeynames, $dbouter, false, true);

if (empty($outer_data)) {
    $dbmiddle->setFieldArray(null);
    $middle_data = array();
} else {
    // load in current data from $outer in case it is needed
    $dbmiddle->setFieldArray($outer_data);
    if (isset($_GET['scrolling']) AND $_GET['scrolling'] == $dbmiddle->getClassName()) {
        // set index number of item to be read from current $where list
        $dbmiddle->setPageNo($_GET['item']);
    } // if
    // get data from the middle table
    $middle_data = $dbmiddle->getData($where);
    if ($dbmiddle->errors) {
        // errors are keyed by object name
        $errors[$dbmiddle->getClassName()] = $dbmiddle->getErrors();
    } // if
    if ($dbmiddle->getNumRows() == 0 AND !$dbmiddle->allow_zero_rows) {
        $errors[] = getLanguageText('sys0088', strtoupper($middle_table)); // 'No entries found on $middle_table'
        if (array_key_exists('choose', $act_buttons)) {
            // this is unusable, so remove it
            unset($act_buttons['choose']);
        } // if
    } // if
    // get any additional data for current record
    $middle_data = $dbmiddle->getExtraData($middle_data);
} // if

// get primary key of current row retrieved from middle entity
$pkeynames = $dbmiddle->getPkeyNamesAdjusted();
$middle_where = array2where($middle_data, $pkeynames, $dbmiddle, false, true);

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
    $dbinner->setOrderBy($string, $dbinner->sql_orderby_seq);
} // if

// look for optional search criteria
if (isset($quicksearch)) {
    // from quicksearch area in list screen
    $dbinner->setSqlQuickSearch($quicksearch, true);
} elseif (isset($search)) {
    // from search screen
    $dbinner->setSqlSearch($search, true);
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

if ($dbmiddle->numrows == 0 AND !$dbmiddle->allow_zero_rows) {
    $dbinner->setFieldArray(null);
    $inner_data = array();
} else {
    // load in current data from $middle in case it is needed
    $dbinner->setFieldArray($middle_data);
	// get data from the database
    $inner_data = $dbinner->getData($inner_where);
    if ($dbinner->errors) {
        // errors are keyed by object name
        $errors[$dbinner->getClassName()] = $dbinner->getErrors();
    } // if

    if ($dbinner->getNumRows() == 0) {
        $errors[] = getLanguageText('sys0088', strtoupper($inner_table)); // 'No entries found on $inner_table'
        if (strtolower($return_action) == 'search') {
            if (isset($return_from)) {
                $messages = $errors;
                // go back to script which generated this profile
                scriptNext($return_from, $where);
            } // if
        } // if
        if (array_key_exists('choose', $act_buttons)) {
            // this is unusable, so remove it
            unset($act_buttons['choose']);
        } // if
    } // if
    $inner_data = $dbinner->getExtraData($inner_data);
} // if

$messages = array_merge($messages, $dbouter->getMessages());
$messages = array_merge($messages, $dbmiddle->getMessages());
$messages = array_merge($messages, $dbinner->getMessages());

if (isset($_GET['action'])) {
    $inner_data = $dbinner->setAction($_GET['action']);
} // if

// check for only one row being found in POPUP mode
if ($dbinner->getNumRows() == 1 AND isset($act_buttons['choose'])) {
    if (array_key_exists('choose_single_row', $settings)) {
        // convert primary key into SQL where format
        $pkeynames = $dbinner->getPkeyNamesAdjusted();
        $selection = array2where($inner_data, $pkeynames, $dbinner);
        // send primary key back to the previous script
        $prev_script = getPreviousScript();
        $prev_task   = getPreviousTask($prev_script);
        $_SESSION['pages'][$prev_script][$prev_task]['selection'] = $selection;
        scriptPrevious($errors, $messages, 'choose');
    } // if
} // if

// get pagination details
$pagination['inner']['numrows']  = $dbinner->getNumRows();
$pagination['inner']['curpage']  = $dbinner->getPageNo();
$pagination['inner']['lastpage'] = $dbinner->getLastPage();

// save these variables for later in the same session
$script_vars['where']     = unqualifyWhere($where);
$script_vars['dbouter']   = serialize($dbouter);
$script_vars['dbmiddle']  = serialize($dbmiddle);
$script_vars['dbinner']   = serialize($dbinner);
$script_vars['scrolling'] = $scrolling;
$script_vars = updateScriptVars ($script_vars);

$dbouter->fieldarray  = $outer_data;  // replace data lost during serialization
$dbmiddle->fieldarray = $middle_data;
$dbinner->fieldarray  = $inner_data;

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbouter;
$xml_objects[][$dbouter->getClassName()]  = &$dbmiddle;
$xml_objects[][$dbmiddle->getClassName()] = &$dbinner;

// build XML document and perform XSL transformation
$view = new radicore_view($screen_structure);
$view->buildXML($xml_objects, $errors, $messages);
exit;

?>
