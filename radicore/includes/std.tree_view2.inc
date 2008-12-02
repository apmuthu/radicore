<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2008 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.tree_view2.inc

// type = tree view 2

// This will list nodes in a tree structure where the tables involved are:
// TREE_TYPE -> TREE_LEVEL -> TREE_NODE
// Each node belogs to a particular TYPE and LEVEL.
// A node can have only one parent but many children.
// The tree_type to be displayed will be passed in $selection.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'read';

// load session variables
initSession();

if (!empty($selection) AND !isset($return_from)) {
    // $selection takes precedence over $where
    $where     = $selection;
    $selection = null;
} // if

if (isset($_POST['quit'])) {
    // clear this script from session details and return to previous page
    if (isset($act_buttons) AND array_key_exists('choose', $act_buttons)) {
        // 'Nothing selected from popup screen'
        scriptPrevious(getLanguageText('sys0083'),null,'quit');
    } else {
        scriptPrevious();
    } // if
} // if

// define action buttons
$act_buttons['expand']   = 'expand';
$act_buttons['collapse'] = 'collapse';
$act_buttons['quit']     = 'close';
if (array_key_exists('select_one', $settings)) {
	if (!is_True($settings['select_one'])) {
    	unset($act_buttons['choosenull']);
    } // if
} // if

// create a class instance for the inner database table
require_once "classes/$inner_table.class.inc";
if (isset($script_vars['dbinner'])) {
    // use data from previous instance for this script
    $dbinner = unserialize($script_vars['dbinner']);
} else {
    $dbinner = new $inner_table;
    // indicate that this object was started from a page controller
    $dbinner->initiated_from_controller = true;
    $dbinner->sql_select  = &$inner_sql_select;
    $dbinner->sql_from    = &$inner_sql_from;
    $dbinner->sql_where   = &$inner_sql_where;
    $dbinner->sql_groupby = &$inner_sql_groupby;
    $dbinner->sql_having  = &$inner_sql_having;
} // if

// the 'choose' button should only be available in popup screens
if (isset($_POST['choose']) or isset($_POST['choosenull'])) {
    $messages = chooseButton($_POST, $dbinner);
} // if

// create a class instance for the outer database table
require_once "classes/$outer_table.class.inc";
if (isset($script_vars['dbouter'])) {
    // use data from previous instance for this script
    $dbouter = unserialize($script_vars['dbouter']);
    // build array of primary keys
    $outer_data = $dbouter->getFieldArray();
} else {
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
    // set sort order (if defined)
    if (!empty($orderby)) {
        $string = validateSortItem('outer', $orderby, $dbouter, $screen_structure);
        $dbouter->setOrderBy($string);
        if (!empty($orderby_seq)) {
            $dbouter->setOrderBySeq($orderby_seq);
        } // if
    } // if
} // if

if (!empty($_POST)) {
    // look for an action which is another script
    $errors = childForm($_POST, array('dbouter' => &$dbouter, 'dbinner' => &$dbinner));
} // if

if (isset($scrolling)) {
    // retrieve values from scrolling array
    $where = $scrolling[$dbouter->getClassName()]['where'];
    $dbouter->setPageNo($scrolling[$dbouter->getClassName()]['curitem']);
} // if
if (empty($where)) {
    scriptPrevious(getLanguageText('sys0082')); // 'No parent has been selected yet.'
} // if

if (isset($_GET['scrolling']) AND $_GET['scrolling'] == $dbouter->getClassName()) {
    // set index number of item to be read from current $where list
    $dbouter->setPageNo($_GET['item']);
} // if

// get data for the outer table
$outer_data = $dbouter->getData($where);

if ($dbouter->errors) {
    // some sort of error - return to previous script
    scriptprevious($dbouter->getErrors(), $messages);
} // if
if ($dbouter->getNumRows() < 1) {
    scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
} // if

// set variables to be included in XML output
$scrolling[$dbouter->getClassName()]['curitem']  = $dbouter->getPageNo();
$scrolling[$dbouter->getClassName()]['lastitem'] = $dbouter->getLastPage();
$scrolling[$dbouter->getClassName()]['where']    = $where;

// get primary key of row retrieved from OUTER entity
$pkeynames = $dbouter->getPkeyNamesAdjusted();
$where = array2where($outer_data, $pkeynames, $dbouter);

// look for optional instructions from previous script
if (!empty($instruction)) {
    $dbobject->setInstruction($instruction);
} // if

// get list of expanded nodes from session data
$expanded = $dbinner->getExpanded();

// look for instruction to expand a single node, or ALL nodes
if (isset($_GET['expand'])) {
    // add this node number to the list
    $expanded[$_GET['expand']] = true;
} // if
if (isset($_POST['expand'])) {
    // remove all nodes from the list
    $expanded = 'ALL';
} // if

// look for instruction to collapse a single node, or ALL nodes
if (isset($_GET['collapse'])) {
    // remove this node number from the list
    if (is_array($expanded)) {
        unset($expanded[$_GET['collapse']]);
    } // if
} // if
if (isset($_POST['collapse'])) {
    // remove all nodes from the list
    $expanded = null;
} // if

// get data for the inner table
// we start with the root node(s) for the selected tree_type
$inner_data = $dbinner->getNodeData($expanded, $where);

if ($dbinner->errors) {
	$errors[$dbinner->getClassName()] = $dbinner->getErrors();
} // if

if (count($inner_data) < 1) {
    $errors[] = getLanguageText('sys0088', strtoupper($inner_table)); // 'No entries found on $inner_table'
} // if
if (isset($_GET['action'])) {
    $fieldarray = $dbinner->setAction($_GET['action']);
} // if

// save these variables for later in the same session
$script_vars['where']     = $where;
$script_vars['dbouter']   = serialize($dbouter);
$script_vars['dbinner']   = serialize($dbinner);
$script_vars['scrolling'] = $scrolling;
$script_vars = updateScriptVars ($script_vars);

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbouter;
$xml_objects[][$dbouter->getClassName()] = &$dbinner;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);
exit;

?>
