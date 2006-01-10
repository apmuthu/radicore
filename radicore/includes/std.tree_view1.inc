<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.tree_view1.inc

// type = tree view 1

// This will list nodes in a tree structure where everything is on the TREE_NODE table.
// A node can have only one parent but many children.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'read';

// load session variables
initSession();

if (isset($_POST['quit'])) {
    // clear this script from session details and return to previous page
    if (isset($act_buttons) AND array_key_exists('choose', $act_buttons)) {
        scriptPrevious(getLanguageText('sys0083')); // 'Nothing selected from popup screen.'
    } else {
        scriptPrevious();
    } // if
} // if

// define action buttons
$act_buttons['expand']   = 'expand';
$act_buttons['collapse'] = 'collapse';
$act_buttons['quit']     = 'close';

// create a class instance for the inner database table
require_once "classes/$table_id.class.inc";
if (isset($script_vars['dbobject'])) {
    // use data from previous instance for this script
    $dbobject = unserialize($script_vars['dbobject']);
} else {
    $dbobject = new $table_id;
    $dbobject->sql_select  = &$sql_select;
    $dbobject->sql_from    = &$sql_from;
    $dbobject->sql_where   = &$sql_where;
    $dbobject->sql_groupby = &$sql_groupby;
    $dbobject->sql_having  = &$sql_having;
} // if

// the 'choose' button should only be available in popup screens
if (isset($_POST['choose'])) {
    $messages = chooseButton($_POST, $dbobject);
} // if

if (!empty($_POST)) {
    // look for an action which is another script
    $errors = childForm($_POST, $dbobject, 'dbobject', null);
} // if

// get list of expanded nodes from session data
$expanded = $dbobject->getExpanded();
// look for optional instruction from previous script
if (!empty($instruction)) {
    if (array_key_exists('expand', $instruction)) {
        $expanded[$instruction['expand']] = true;
        unset($instruction['expand']);
    } // if
    // load remaining instructions into the database object
    $dbobject->setInstruction($instruction);
} // if

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

// get data for the database table, starting with the root node(s)
$fieldarray = $dbobject->getNodeData($expanded, null);

// retrieve any errors
$errors = array_merge($errors, $dbobject->getErrors());

if ($dbobject->getNumRows() < 1) {
    $messages[] = getLanguageText('sys0085'); // 'Nothing retrieved from the database.'
} // if
if (isset($_GET['action'])) {
    $fieldarray = $dbobject->setAction($_GET['action']);
} // if

// ensure script variables are available throughout this session
unset($script_vars['selection']);
$script_vars['where']    = $where;
$script_vars['dbobject'] = serialize($dbobject);
$PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'
$_SESSION[$PHP_SELF][$task_id] = $script_vars;

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbobject;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);
exit;

?>
