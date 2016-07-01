<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
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
$mode = 'tree';

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
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $dbinner->restart($return_from, $return_action, $return_string, $return_files);
        $return_errors = array_merge($errors, $dbinner->getErrors());
        $errors        = array();
    } // if
    // get current data from this instance
    $inner_data = $dbinner->getFieldArray();
} else {
    $dbinner = new $inner_table;
    // indicate that this object was started from a page controller
    $dbinner->initiated_from_controller = true;
    $dbinner->zone                      = 'inner';
    $dbinner->sql_select  = &$inner_sql_select;
    $dbinner->sql_from    = &$inner_sql_from;
    $dbinner->sql_where   = &$inner_sql_where;
    $dbinner->sql_groupby = &$inner_sql_groupby;
    $dbinner->sql_having  = &$inner_sql_having;
    $null = $dbinner->initialise($where, $selection);
    if ($dbinner->errors) {
        scriptPrevious($dbinner->errors); // return to previous task to display errors
    } // if
} // if

// the 'choose' button should only be available in popup screens
if (isset($_POST['choose']) or isset($_POST['choosenull'])) {
    list($choose_errors, $messages) = chooseButton($_POST, $dbinner, 'dbinner');
    if (!empty($choose_errors)) {
        $errors[$dbinner->getClassName()] = $choose_errors;
    } // if
} // if

// create a class instance for the outer database table
require_once "classes/$outer_table.class.inc";
if (isset($script_vars['dbouter'])) {
    // use data from previous instance for this script
    $dbouter = unserialize($script_vars['dbouter']);
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $dbouter->restart($return_from, $return_action);
    } // if
    // get current data from this instance
    $outer_data = $dbouter->getFieldArray();
} else {
    $dbouter = new $outer_table;
    // indicate that this object was started from a page controller
    $dbouter->initiated_from_controller = true;
    $dbouter->zone                      = 'outer';
    $dbouter->setRowsPerPage(1);  // scroll through one item at a time
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

if (!empty($_POST)) {
    // look for an action which is another script
    $task_button = check_task_button($_POST);
    if (!empty($task_button)) {
        $child_errors = childForm($_POST, array('dbouter' => &$dbouter, 'dbinner' => &$dbinner), $task_button);
        if (is_array($child_errors)) {
            $errors = array_merge($errors, $child_errors);
        } // if
    } // if
} // if

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
    scriptPrevious(getLanguageText('sys0082')); // 'No parent has been selected yet.'
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

// get any additional data for current record
$outer_data = $dbouter->getExtraData($outer_data);

// set variables to be included in XML output
$scrolling[$dbouter->getClassName()]['curitem']  = $dbouter->getPageNo();
$scrolling[$dbouter->getClassName()]['lastitem'] = $dbouter->getLastPage();
$scrolling[$dbouter->getClassName()]['where']    = $where;

// get primary key of row retrieved from OUTER entity
$pkeynames = $dbouter->getPkeyNamesAdjusted();
$where = array2where($outer_data, $pkeynames, $dbouter);

if (!empty($errors)) {
    if (isset($_POST['select'])) {
        // reset 'selected' checkboxes in $inner_data so that they show up in the screen
        foreach ($inner_data as $rownum => $rowdata) {
            // note that $rownum start at 1 while $fieldarray starts at zero
            if (isset($_POST['select'][$rownum+1])) {
                $inner_data[$rownum]['selected'] = true;
            } else {
                unset($inner_data[$rownum]['selected']);
            } // if
        } // foreach
        $dbinner->setFieldArray($inner_data);
    } // if
} else {
    // look for optional instructions from previous script
    if (!empty($instruction)) {
        $dbinner->setInstruction($instruction);
    } // if

    if (isset($_SESSION['rowsperpage'])) {
        $dbinner->setRowsPerPage($_SESSION['rowsperpage']);
    } // if

    if (isset($_GET['pagesize'])) {
        $dbinner->setRowsPerPage($_GET['pagesize']);
        $_SESSION['rowsperpage'] = $_GET['pagesize'];
    } // if

    // obtain the required page number (optional)
    if (isset($_GET['page'])) {
        $dbinner->setPageNo($_GET['page']);
    } // if

    // get list of expanded nodes from session data
    $expanded = $dbinner->getExpanded();

    // look for instruction to expand a single node, or ALL nodes
    if (isset($_GET['expand'])) {
        // add this node number to the list
        $expanded[$_GET['expand']] = true;
    } // if

    if (isset($_POST['expand'])) {
        $expanded = 'ALL';  // expand all nodes
    } elseif (empty($expanded)) {
        if (!empty($settings) AND array_key_exists('auto_expand', $settings)) {
            $expanded = 'ALL';  // expand all nodes
        } // if
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
} // if

if (count($inner_data) < 1) {
    $errors[] = getLanguageText('sys0088', strtoupper($inner_table)); // 'No entries found on $inner_table'
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
$script_vars['dbinner']   = serialize($dbinner);
$script_vars['scrolling'] = $scrolling;
$script_vars = updateScriptVars ($script_vars);

$dbouter->fieldarray = $outer_data;  // replace data lost during serialization
$dbinner->fieldarray = $inner_data;

if (isset($return_errors)) {
    // include errors created by returning script
    $errors = array_merge($errors, $return_errors);
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
