<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.tree_view1.inc

// type = tree view 1

// This will list nodes in a tree structure where everything is on the TREE_NODE table.
// A node can have only one parent but many children.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'tree';

// load session variables
initSession();

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
require_once "classes/$table_id.class.inc";
if (isset($script_vars['dbobject'])) {
    // use data from previous instance for this script
    $dbobject = unserialize($script_vars['dbobject']);
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $dbobject->restart($return_from, $return_action);
    } // if
    // get current data from this instance
    $fieldarray = $dbobject->getFieldArray();
} else {
    $dbobject = new $table_id;
    // indicate that this object was started from a page controller
    $dbobject->initiated_from_controller = true;
    $dbobject->sql_select  = &$sql_select;
    $dbobject->sql_from    = &$sql_from;
    $dbobject->sql_where   = &$sql_where;
    $dbobject->sql_groupby = &$sql_groupby;
    $dbobject->sql_having  = &$sql_having;
    // perform any initialisation
    $where = $dbobject->initialise($where, $selection);
} // if

// the 'choose' button should only be available in popup screens
if (isset($_POST['choose']) or isset($_POST['choosenull'])) {
    list($choose_errors, $messages) = chooseButton($_POST, $dbobject, 'dbobject');
    if (!empty($choose_errors)) {
        $errors[$dbobject->getClassName()] = $choose_errors;
    } // if
} // if

if (!empty($_POST)) {
    // look for an action which is another script
    $child_errors = childForm($_POST, array('dbobject' => $dbobject));
    if (is_array($child_errors)) {
        $errors = array_merge($errors, $child_errors);
    } // if
} // if

if (!empty($errors)) {
    if (isset($_POST['select'])) {
        // reset 'selected' checkboxes in $fieldarray so that they show up in the screen
        foreach ($fieldarray as $rownum => $rowdata) {
            // note that $rownum start at 1 while $fieldarray starts at zero
            if (isset($_POST['select'][$rownum+1])) {
                $fieldarray[$rownum]['selected'] = true;
            } else {
                unset($fieldarray[$rownum]['selected']);
            } // if
        } // foreach
        $dbobject->setFieldArray($fieldarray);
    } // if
} else {
    // look for optional instructions from previous script
    if (!empty($instruction)) {
        $dbobject->setInstruction($instruction);
    } // if

    if (isset($_SESSION['rowsperpage'])) {
        $dbobject->setRowsPerPage($_SESSION['rowsperpage']);
    } // if

    if (isset($_GET['pagesize'])) {
        $dbobject->setRowsPerPage($_GET['pagesize']);
        $_SESSION['rowsperpage'] = $_GET['pagesize'];
    } // if

    // obtain the required page number (optional)
    if (isset($_GET['page'])) {
        $dbobject->setPageNo($_GET['page']);
    } // if

    // get list of expanded nodes from session data
    $expanded = $dbobject->getExpanded();

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

    // get data for the database table, starting with the root node(s)
    $fieldarray = $dbobject->getNodeData($expanded, null);

    if ($dbobject->errors) {
	    $errors[$dbobject->getClassName()] = $dbobject->getErrors();
    } // if

    if ($dbobject->getNumRows() < 1) {
        $messages[] = getLanguageText('sys0085'); // 'Nothing retrieved from the database.'
    } // if
    if (isset($_GET['action'])) {
        $fieldarray = $dbobject->setAction($_GET['action']);
    } // if
} // if

// get pagination details
$pagination['main']['numrows']  = $dbobject->getNumRows();
$pagination['main']['curpage']  = $dbobject->getPageNo();
$pagination['main']['lastpage'] = $dbobject->getLastPage();

// save these variables for later in the same session
$script_vars['where']    = $where;
$script_vars['dbobject'] = serialize($dbobject);
$script_vars = updateScriptVars ($script_vars);

$dbobject->fieldarray = $fieldarray;  // replace data lost during serialization

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbobject;

// build XML document and perform XSL transformation
$view = new radicore_view($screen_structure);
$view->buildXML($xml_objects, $errors, $messages);
exit;

?>
