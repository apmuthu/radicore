<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2007 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.list2.inc

// type = list2

// This will list rows of MANY in a ONE-to-MANY relationship.
// The primary key of ONE will be passed in $where from the previous screen.

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
    // get data from previous instance
    $outer_data = $dbouter->getFieldArray();
    if (!is_string(key($outer_data))) {
        // indexed by row, so use first row only
        $outer_data = $outer_data[key($outer_data)];
    } // if
} else {
    // create new instance for initial activation of this script
    $dbouter = new $outer_table;
    $dbouter->sql_select     = &$outer_sql_select;
    $dbouter->sql_from       = &$outer_sql_from;
    $dbouter->sql_where      = &$outer_sql_where;
    $dbouter->sql_groupby    = &$outer_sql_groupby;
    $dbouter->sql_having     = &$outer_sql_having;
    $dbouter->sql_orderby_table = &$outer_sql_orderby_table;
    if (!empty($outer_sql_orderby)) {
        $dbouter->setDefaultOrderby($outer_sql_orderby);
    } // if
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
    // perform any initialisation
    if (!empty($selection)) {
        $selection = $dbouter->initialise($selection, $where);
    } else {
        $where = $dbouter->initialise($where);
    } // if
} // if

// create a class instance for the INNER database table
require_once "classes/$inner_table.class.inc";
if (isset($script_vars['dbinner'])) {
    // use previous instance from session data
    $dbinner = unserialize($script_vars['dbinner']);
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
    if (!empty($selection)) {
        $null = $dbinner->initialise($selection, $where);
    } else {
        $null = $dbinner->initialise($where);
    } // if
} // if

// the 'choose' button should only be available in popup screens
if (isset($_POST['choose']) or isset($_POST['choosenull'])) {
    $messages = chooseButton($_POST, $dbinner);
} // if

if (!empty($_POST)) {
    // look for an action which is another script
    $errors = childForm($_POST, array('dbinner' => $dbinner), $where);
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
    $dbouter->reset($where);
} // if

// get data for the outer table
$outer_data = $dbouter->getData($where);
if ($dbouter->errors) {
    // some sort of error
    if ($dbouter->getLastPage() <= 1) {
        // only 1 entry requested, so return to previous script
        scriptprevious($dbouter->getErrors(), $messages);
    } else {
        // multiple entries requested, so display error message
        $errors[$dbouter->getClassName()] = $dbouter->getErrors();
    } // if
} // if
$messages = array_merge($messages, $dbouter->getMessages());
if ($dbouter->getNumRows() < 1) {
    if (count($page_stack) > 2) {
        // 'Nothing retrieved from database table $outer'
        scriptPrevious(getLanguageText('sys0090', strtoupper($dbouter->getTableName())));
    } else {
        // 'Nothing retrieved from database table $outer'
        $messages[] = getLanguageText('sys0090', strtoupper($dbouter->getTableName()));
    } // if
} // if

// get any additional data for current record
$outer_data = $dbouter->getExtraData($outer_data);

// set variables to be included in XML output
$scrolling[$dbouter->getClassName()]['curitem']  = $dbouter->getPageNo();
$scrolling[$dbouter->getClassName()]['lastitem'] = $dbouter->getLastPage();
$scrolling[$dbouter->getClassName()]['where']    = $where;

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

// get primary key of row retrieved from OUTER entity
$where = array2where($outer_data, $dbouter->getPkeyNames(), $dbouter);

// load in current data from $outer in case it is needed
$dbinner->setFieldArray($outer_data);

// obtain the required page number (optional)
if (isset($_GET['page'])) {
    $dbinner->setPageNo($_GET['page']);
} // if

if (isset($_POST['reset'])) {
    // initialise all settings to start afresh
    $dbinner->reset($where);
} // if

// get data from the database
if (!empty($outer_data)) {
	$inner_data = $dbinner->getData($where);
} // if
if ($dbinner->errors) {
    $errors[$dbinner->getClassName()] = $dbinner->getErrors();
} // if
if ($dbinner->getNumRows() == 0) {
    $errors[] = getLanguageText('sys0088', strtoupper($inner_table)); // 'no entries found on $inner_table'
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
        $previous = $_SESSION[$PHP_SELF]['previous'];
        $_SESSION[$previous]['selection'] = $selection;
        scriptPrevious(null, null, 'choose');
    } // if
} // if

// get pagination details
$pagination['inner']['numrows']  = $dbinner->getNumRows();
$pagination['inner']['curpage']  = $dbinner->getPageNo();
$pagination['inner']['lastpage'] = $dbinner->getLastPage();

// save these variables for later in the same session
$script_vars['where']     = unqualifyWhere($where);
$script_vars['dbouter']   = serialize($dbouter);
$script_vars['dbinner']   = serialize($dbinner);
$script_vars['scrolling'] = $scrolling;
$script_vars = updateScriptVars ($script_vars);
// get sort details
$orderby = $dbinner->getOrderBy();
$orderby_seq = $dbinner->getOrderBySeq();

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbouter;
$xml_objects[][$dbouter->getClassName()] = &$dbinner;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);
exit;

?>
