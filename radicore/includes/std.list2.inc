<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2015 by Radicore Software Limited <http://www.radicore.org>
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

if (isset($act_buttons['choose'])) {
    if ($return_action == 'insert' AND !empty($selection)) {
    	// send selection back to the previous script
        $prev_script = getPreviousScript();
        $prev_task   = getPreviousTask($prev_script);
        $_SESSION['pages'][$prev_script][$prev_task]['selection'] = $selection;
        scriptPrevious(null, null, 'choose');
    } // if
} // if

if (!empty($selection) AND (!isset($return_from) OR $return_action == 'choose')) {
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
        $dbouter->restart($return_from, $return_action, $return_string, $return_files);
    } // if
    // get data from this instance
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
    } // if
    // scroll through one item at a time
    $dbouter->setRowsPerPage(1);
    // check that primary key is complete
    $dbouter->checkPrimaryKey = true;
    // perform any initialisation
    $where = $dbouter->initialise($where, $selection);
    if ($dbouter->errors) {
        if (!empty($dbouter->messages)) {
        	$messages = array_merge($messages, $dbouter->getMessages);
        } // if
        scriptPrevious($dbouter->getErrors(), $messages);
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

// create a class instance for the INNER database table
require_once "classes/$inner_table.class.inc";
if (isset($script_vars['dbinner'])) {
    // use previous instance from session data
    $dbinner = unserialize($script_vars['dbinner']);
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $dbinner->restart($return_from, $return_action, $return_string, $return_files);
    } // if
    // get data from this instance
    $inner_data = $dbinner->getFieldArray();
} else {
    // create new instance for initial activation of this script
    $dbinner = new $inner_table;
    // indicate that this object was started from a page controller
    $dbinner->initiated_from_controller = true;
    $dbinner->zone                      = 'inner';
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
    // perform any initialisation
    $inner_where = $dbinner->initialise($where, $selection);
    if ($dbouter->errors) {
        if (!empty($dbinner->messages)) {
        	$messages = array_merge($messages, $dbinner->getMessages);
        } // if
        scriptPrevious($dbinner->getErrors(), $messages);
    } // if
} // if

// make each object available to its parent or child
$dbouter->setChildObject($dbinner);
$dbinner->setParentObject($dbouter);

// the 'choose' button should only be available in popup screens
if (isset($_POST['choose']) or isset($_POST['choosenull'])) {
    list($choose_errors, $messages) = chooseButton($_POST, $dbinner, 'dbinner');
    if (!empty($choose_errors)) {
        $errors[$dbinner->getClassName()] = $choose_errors;
    } // if

} elseif (isset($_POST['reset'])) {
    // initialise all settings to start afresh
    $where = $dbouter->reset($where, true);  // but do not lose current ORDERBY settings

} elseif (!empty($_POST)) {
    if ($task_button = check_task_button($_POST)) {
        // look for an action which is another script
        $child_errors = childForm($_POST, array('dbouter' => &$dbouter, 'dbinner' => &$dbinner), $task_button);
        if (is_array($child_errors)) {
            $errors = array_merge($errors, $child_errors);
        } // if
    } // if
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
        } else {
            $dbouter->setPageNo($scrolling[$dbouter->getClassName()]['curitem']);
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
        // 'No parent has been selected yet.'
        scriptPrevious(getLanguageText('sys0082'));
    } // if
} // if

// get data for the outer table
$outer_data = $dbouter->getData($where);

$messages = array_merge($messages, $dbouter->getMessages());

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

if ($dbouter->getNumRows() < 1) {
    if (strtolower($return_action) == 'search') {
        if (isset($return_from)) {
            $messages[] = getLanguageText('sys0089'); // 'Nothing was found matching this profile'
            // go back to script which generated this profile
            scriptNext($return_from, $where);
        } // if
    } // if
    if (!empty($return_from) AND !empty($return_action) AND !empty($where)) {
    	// send selection back to the previous script
        $prev_script = getPreviousScript();
        $prev_task   = getPreviousTask($prev_script);
        $_SESSION['pages'][$prev_script][$prev_task]['selection'] = $where;
        scriptPrevious($errors, $messages, 'choose');
    } // if
    if ($dbouter->allow_empty_where == TRUE) {
    	// this task is allowed to have blank selection and zero records
	} else {
	    if (count($page_stack) > 2) {
	        // 'Nothing retrieved from database table $outer'
	        scriptPrevious(getLanguageText('sys0090', strtoupper($dbouter->getTableName())));
	    } else {
	        // 'Nothing retrieved from database table $outer'
	        $messages[] = getLanguageText('sys0090', strtoupper($dbouter->getTableName()));
	    } // if
	} // if
} // if

// get any additional data for current record
$outer_data = $dbouter->getExtraData($outer_data);

// set variables to be included in XML output
$scrolling[$dbouter->getClassName()]['curitem']  = $dbouter->getPageNo();
$scrolling[$dbouter->getClassName()]['lastitem'] = $dbouter->getLastPage();
$scrolling[$dbouter->getClassName()]['where']    = $where;

// save these variables for later in the same session in case INNER performs a scriptNext()
$script_vars['where']     = unqualifyWhere($where);
$script_vars['dbouter']   = serialize($dbouter);
$script_vars['scrolling'] = $scrolling;
$script_vars = updateScriptVars ($script_vars);

$dbouter->fieldarray = $outer_data;  // replace data lost during serialization

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

// convert to foreign key names which relate this child to this parent
$fkeyvalues = getForeignKeyValues($dbouter, $dbinner);
if (!empty($fkeyvalues)) {
    $inner_where = array2where($fkeyvalues);
} else {
    // get primary key of current row retrieved from OUTER entity
    $pkeynames = $dbouter->getPkeyNamesAdjusted();
    $inner_where = array2where($outer_data, $pkeynames, $dbouter, false, true);
} // if

// merge OUTER and INNER where to get selection criteria for INNER
$pkeynames = $dbouter->getPkeyNamesAdjusted();  // reduce to current record
$outer_where = array2where($outer_data, $pkeynames, $dbouter, false, true);
$inner_where = mergeWhere($outer_where, $inner_where);

// obtain the required page number (optional)
if (isset($_GET['page'])) {
    $dbinner->setPageNo($_GET['page']);
} // if

if (isset($_POST['reset'])) {
    // initialise all settings to start afresh
    $dbinner->reset($inner_where);
} // if

if (empty($outer_data)) {
    $inner_data = $dbinner->setFieldArray(null);
} else {
    // get data for the inner entity from the database
	$inner_data = $dbinner->getData($inner_where);

	if ($dbinner->tablename == $dbouter->alt_language_table) {
	    // ensure that default entries exist for all supported languages
    	//$inner_data = $dbinner->getLanguageEntries($inner_data, $outer_data, $dbouter->alt_language_cols);
    } // if
    if ($dbinner->errors) {
        $errors = array_merge($errors, $dbinner->getErrors());
    } // if

} // if

if (empty($errors) AND $dbinner->getNumRows() == 0) {
    // 'no entries found on $inner_table'
    $errors[] = getLanguageText('sys0088', strtoupper($inner_table));
    if (strtolower($return_action) == 'search') {
        if (isset($return_from)) {
            $messages = $errors;
            // go back to script which generated this profile
            scriptNext($return_from, $where);
        } // if
    } // if
} // if
if (!empty($errors)) {
    if (array_key_exists('choose', $act_buttons)) {
        // this is unusable, so remove it
        unset($act_buttons['choose']);
    } // if
} // if

//if (!empty($inner_data)) {
    // get any additional data for current record
    $inner_data = $dbinner->getExtraData($inner_data);
//} // if

if ($dbinner->errors) {
    $errors[$dbinner->getClassName()] = $dbinner->getErrors();
} // if
if ($dbinner->messages) {
    $messages = array_merge($messages, $dbinner->getMessages());
} // if

if (isset($_GET['action'])) {
    $inner_data = $dbinner->setAction($_GET['action']);
} // if

// check for only one row being found in POPUP mode
if ($dbinner->getNumRows() == 1 AND isset($act_buttons['choose'])) {
    if (array_key_exists('choose_single_row', $settings)) {
        $prev_script = getPreviousScript();
        $prev_task   = getPreviousTask($prev_script);
        // convert selection into SQL where format
        $pkey_array = $dbinner->getPkeyArray($fieldarray, $prev_task);
        $selection = array2where($pkey_array);
        // send selection back to the previous script
        $_SESSION['pages'][$prev_script][$prev_task]['selection'] = $selection;
        scriptPrevious(null, null, 'choose');
    } // if
} // if

// get pagination details
$pagination['inner']['numrows']  = $dbinner->getNumRows();
$pagination['inner']['curpage']  = $dbinner->getPageNo();
$pagination['inner']['lastpage'] = $dbinner->getLastPage();

// get sort details
//$orderby     = $dbinner->getOrderBy();
//$orderby_seq = $dbinner->getOrderBySeq($orderby);

// save these variables for later in the same session
$script_vars['where']      = unqualifyWhere($where);
$script_vars['dbouter']    = serialize($dbouter);
$script_vars['dbinner']    = serialize($dbinner);
$script_vars['scrolling']  = $scrolling;
$script_vars['pagination'] = $pagination;
$script_vars = updateScriptVars ($script_vars);

$dbouter->fieldarray = $outer_data;  // replace data lost during serialization
$dbinner->fieldarray = $inner_data;

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbouter;
$xml_objects[][$dbouter->getClassName()] = &$dbinner;

// build XML document and perform XSL transformation
$view = new radicore_view($screen_structure);
$html = $view->buildXML($xml_objects, $errors, $messages);
echo $html;
exit;

?>
