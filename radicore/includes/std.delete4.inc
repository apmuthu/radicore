<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2015 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.delete4.inc

// type = delete4

// This will delete rows in a ONE-to-MANY relationship.
// It will show a single row from the ONE (outer) table and multiple rows from
// the MANY (inner) table.
// When the DELETE button is pressed it will delete the selected record from
// the ONE table as well as all associated records on the MANY table.
// The primary key of ONE will be passed in $where from the previous screen.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'delete';

// load session variables
initSession();

$original_where     = $where;
$original_selection = $selection;
//if (!empty($selection) AND !isset($return_from)) {
//    // $selection takes precedence over $where
//    $where     = $selection;
//    $selection = null;
//} // if

if (isset($_POST['quit'])) {
    // cancel this screen, return to previous screen
    scriptPrevious(null, null, 'quit');
} // if

// define action buttons
$act_buttons['submitBtn'] = 'submit';  // do not use name 'submit' as this conflicts with javascript 'submit()' function.
$act_buttons['quit']      = 'cancel';

// create a class instance for the OUTER database table
require_once "classes/$outer_table.class.inc";
if (isset($script_vars['dbouter'])) {
    // use previous instance from session data
    $dbouter = unserialize($script_vars['dbouter']);
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $dbouter->restart($return_from, $return_action);
    } // if
    // get data from previous instance
    $outer_data = $dbouter->getFieldArray();
} else {
    // create new instance for initial activation of this script
    $dbouter = new $outer_table;
    // indicate that this object was started from a page controller
    $dbobject->initiated_from_controller = true;
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
    if ($dbouter->errors) {
        scriptPrevious($dbouter->getErrors(), $messages, 'fail');
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

// look for SUBMIT button
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // look for an action which is another script
    $task_button = check_task_button($_POST);
    if (!empty($task_button)) {
        // look for a navigation or popup button which jumps to another script
        $child_errors = childForm($_POST, array('dbobject' => $dbobject), $task_button);
        if (is_array($child_errors)) {
            $errors[$dbobject->getClassName()] = $child_errors;
        } // if

    } else {
        $submit_button = check_submit_button($act_buttons, $_POST);
        if (empty($errors) AND !empty($submit_button)) {
            $dbouter->startTransaction();
            // delete this record from the database
            $outer_data = $dbouter->deleteRecord($outer_data);
            // retrieve errors from database object
            $errors = $dbouter->getErrors();
            if (empty($errors)) {
                $messages[] = getLanguageText('sys0004', 1, strtoupper($dbouter->tablename));
                $errors = $dbouter->commit();
            } // if
            if (empty($errors)) {
                if ($scrolling[$dbouter->getClassName()]['lastitem'] == 1) {
                    // last item has been deleted, so return to previous screen
                    scriptPrevious(null, $messages, 'delete', $dbouter->getInstruction());
                } // if
            } else {
                $dbouter->rollback();
            } // if
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
        $dbinner->restart($return_from, $return_action);
    } // if
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
    } elseif (!empty($task_orderby)) {
        $dbinner->setDefaultOrderby($task_orderby);
    } // if
    // perform any initialisation
    $null = $dbinner->initialise($original_where, $original_selection);
    if ($dbinner->errors) {
        scriptPrevious($dbinner->getErrors(), $messages, 'fail');
    } // if
} // if

// make each object available to its parent or child
$dbouter->setChildObject($dbinner);
$dbinner->setParentObject($dbouter);

if (isset($scrolling)) {
    // retrieve values from scrolling array
    $where = $scrolling[$dbouter->getClassName()]['where'];
    if (isset($_GET['scrolling']) AND $_GET['scrolling'] == $dbouter->getClassName()) {
        // set index number of item to be read from current $where list
        $dbouter->setPageNo($_GET['item']);
    } else {
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

if (isset($_POST['reset'])) {
    // initialise all settings to start afresh
    $where = $dbouter->reset($where);
} // if

// get data for the outer table
$outer_data = $dbouter->getData($where);
if ($dbouter->errors) {
    // some sort of error
    if ($dbouter->getLastPage() <= 1) {
        // only 1 entry requested, so return to previous script
        scriptprevious($dbouter->getErrors(), $messages, 'fail');
    } else {
        // multiple entries requested, so display error message
        $errors = $dbouter->getErrors();
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

if (empty($errors)) {
    // check that this record can be deleted
	$outer_data = $dbouter->validateDelete($outer_data);
    if ($dbouter->errors) {
    	$errors[$dbouter->getClassName()] = $dbouter->getErrors();
    } // if
    // get any extra data and merge with $fieldarray
    $outer_data = $dbouter->getExtraData($outer_data);
} // if

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
    $dbinner->setOrderBy($string, $dbinner->sql_orderby_seq);
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

// get primary key of row retrieved from OUTER entity
$pkeynames = $dbouter->getPkeyNamesAdjusted();
$where = array2where($outer_data, $pkeynames, $dbouter);

if (isset($_POST['reset'])) {
    // initialise all settings to start afresh
    $dbinner->reset($where);
} // if

// get data from the database
$inner_data = $dbinner->getData($where);
if ($dbinner->errors) {
    $errors[$dbinner->getClassName()] = $dbinner->getErrors();
} // if

// get any additional data for current record
$inner_data = $dbinner->getExtraData($inner_data);

if (isset($_GET['action'])) {
    $fieldarray = $dbinner->setAction($_GET['action']);
} // if

// check for only one row being found in POPUP mode
if ($dbinner->getNumRows() == 1 AND isset($act_buttons['choose'])) {
    if (isset($settings['choose_single_row'])) {
        // convert primary key into SQL where format
        $selection = array2where($inner_data, $dbinner->getPkeyNames(), $dbinner);
        // send primary key back to the previous script
        $PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'
        $previous = $_SESSION['pages'][$PHP_SELF]['previous'];
        $_SESSION['pages'][$previous]['selection'] = $selection;
        scriptPrevious(null, null, 'choose');
    } // if
} // if

if ($errors) {
    // remove the 'submit' button
    unset($act_buttons['submitBtn']);
} else {
    $messages[] = getLanguageText('sys0086'); // 'Press SUBMIT to confirm deletion.'
    $messages   = array_unique($messages);
} // if

// get pagination details
$pagination['inner']['numrows']  = $dbinner->getNumRows();
$pagination['inner']['curpage']  = $dbinner->getPageNo();
$pagination['inner']['lastpage'] = $dbinner->getLastPage();

// get sort details
//$orderby     = $dbinner->getOrderBy();
//$orderby_seq = $dbinner->getOrderBySeq($orderby);

// save these variables for later in the same session
$script_vars['where']     = unqualifyWhere($where);
$script_vars['dbouter']   = serialize($dbouter);
$script_vars['dbinner']   = serialize($dbinner);
$script_vars['scrolling'] = $scrolling;
$script_vars = updateScriptVars ($script_vars);

$dbouter->fieldarray = $outer_data;  // replace data lost during serialization
$dbinner->fieldarray = $inner_data;

if ($_SERVER['REQUEST_METHOD'] == 'POST' AND empty($errors)) {
    // repeat current task with GET instead of POST
    scriptNext($GLOBALS['task_id'], $where);
} // if

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbouter;
$xml_objects[][$dbouter->getClassName()] = &$dbinner;

// build XML document and perform XSL transformation
$view = new radicore_view($screen_structure);
$html = $view->buildXML($xml_objects, $errors, $messages);
echo $html;
exit;

?>
