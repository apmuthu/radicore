<?php
//*****************************************************************************
// Copyright 2003-2006 by A J Marston <http://www.tonymarston.net>
// Licensed to Radicore Software Limited <http://www.radicore.org>
//*****************************************************************************

//*****************************************************************************
// This is the menu page.
// The user is brought here immediately after logging on.
//*****************************************************************************

$xsl_file = 'menu.xsl';       // xsl file for transformation

// identify mode for XSL file
$mode = 'read';

require_once 'include.general.inc';

// load session variables
initSession();

if (isset($_GET['motd']) AND is_True($_GET['motd'])) {
    $today = getTimeStamp('date');
    $role_id = $_SESSION['role_id'];
    $motd =& singleton::getInstance('mnu_motd');
    $where = "motd_id IS NOT NULL AND start_date<='$today' AND end_date>='$today' AND (role_id IS NULL OR role_id='$role_id')";
    $count = $motd->getCount($where);
    if ($count > 0) {
    	// show the MOTD screen
    	scriptNext('mnu_motd(show)', $where);
    } // if
} // if

require_once 'classes/mnu_todo.class.inc';
$db_todo = new mnu_todo;

// insert label text
$db_todo->xsl_params['text']['todo-user'] = getLanguageText('xsl_todo_user');

// ****************************************************************************

// get paginaton details for 'mnu_todo'
if (isset($pagination['mnu_todo'])) {
   $db_todo->setPageNo($pagination['mnu_todo']['curpage']);
} // if
if (isset($_GET['pagination']) AND $_GET['pagination'] == 'mnu_todo') {
   // set index number of item to be read from current $where list
   $db_todo->setPageNo($_GET['page']);
} // if

// get any 'to do' items for the current user
$today = getTimeStamp('date');
$db_todo->sql_select  = 'mnu_todo.user_id, item_desc, due_date, is_complete';
$db_todo->setRowsPerPage(10);
$db_todo->sql_where = "is_complete='N' AND due_date - INTERVAL visibility DAY <= '$today'";
$todo_data = $db_todo->getData("user_id='{$_SESSION['logon_user_id']}'");
$errors = array_merge($errors, $db_todo->getErrors());

// save pagination details for XML output
$pagination['mnu_todo']['numrows']  = $db_todo->getNumRows();
$pagination['mnu_todo']['curpage']  = $db_todo->getPageNo();
$pagination['mnu_todo']['lastpage'] = $db_todo->getLastPage();

// ****************************************************************************

if (!empty($_POST)) {
    // look for an action which is another script
    $errors = childForm($_POST, null, null);
} // if

// ****************************************************************************

require_once 'classes/wf_workitem_role.class.inc';
$dbworkitem_role = new wf_workitem_role;

// insert label text
$dbworkitem_role->xsl_params['text']['workitems-for-role'] = getLanguageText('xsl_workitems_role');

if (isset($_GET['case_id']) and isset($_GET['workitem_id'])) {
   // a workitem has been selected from the current screen, so jump to it now
   $case_id     = addslashes($_GET['case_id']);
   $workitem_id = addslashes($_GET['workitem_id']);
   $where = "case_id='$case_id' AND workitem_id='$workitem_id'";
   $workitem_data = $dbworkitem_role->getData($where);
   if ($dbworkitem_role->errors) {
       $errors = array_merge($errors, $dbworkitem_role->getErrors());
   } elseif (empty($workitem_data)) {
       // "Requested record not found"
       $errors[] = getLanguageText('sys0119');
   } else {
       $task_id = $workitem_data[0]['task_id'];
       $where   = $workitem_data[0]['context'];
       scriptNext($task_id, $where);
   } // if
} // if

// ****************************************************************************

// get paginaton details for 'workitem_role'
if (isset($pagination['workitem_role'])) {
   $dbworkitem_role->setPageNo($pagination['workitem_role']['curpage']);
} // if
if (isset($_GET['pagination']) AND $_GET['pagination'] == 'workitem_role') {
   // set index number of item to be read from current $where list
   $dbworkitem_role->setPageNo($_GET['page']);
} // if

// get any workitems for the current role
$dbworkitem_role->sql_orderby = 'enabled_date';
$dbworkitem_role->setRowsPerPage(10);
$workitem_data = $dbworkitem_role->getData("role_id='{$_SESSION['role_id']}' AND user_id IS NULL AND workitem_status='EN' AND transition_trigger='USER'");
$errors = array_merge($errors, $dbworkitem_role->getErrors());

// save pagination details for XML output
$pagination['workitem_role']['numrows']  = $dbworkitem_role->getNumRows();
$pagination['workitem_role']['curpage']  = $dbworkitem_role->getPageNo();
$pagination['workitem_role']['lastpage'] = $dbworkitem_role->getLastPage();

// ****************************************************************************

require_once 'classes/wf_workitem_user.class.inc';
$dbworkitem_user = new wf_workitem_user;

// insert label text
$dbworkitem_user->xsl_params['text']['workitems-for-user'] = getLanguageText('xsl_workitems_user');

// get paginaton details for 'workitem_user'
if (isset($pagination['workitem_user'])) {
   $dbworkitem_user->setPageNo($pagination['workitem_user']['curpage']);
} // if
if (isset($_GET['pagination']) AND $_GET['pagination'] == 'workitem_user') {
   // set index number of item to be read from current $where list
   $dbworkitem_user->setPageNo($_GET['page']);
} // if

// get any workitems for the current user
$dbworkitem_user->sql_orderby = 'enabled_date';
$dbworkitem_user->setRowsPerPage(10);
$workitem_data = $dbworkitem_user->getData("user_id='{$_SESSION['logon_user_id']}' AND workitem_status='EN' AND transition_trigger='USER'");
$errors = array_merge($errors, $dbworkitem_user->getErrors());

// save pagination details for XML output
$pagination['workitem_user']['numrows']  = $dbworkitem_user->getNumRows();
$pagination['workitem_user']['curpage']  = $dbworkitem_user->getPageNo();
$pagination['workitem_user']['lastpage'] = $dbworkitem_user->getLastPage();

// save this in session data
$script_vars['pagination'] = $pagination;
$PHP_SELF = getSelf();
$_SESSION['pages'][$PHP_SELF][$task_id] = $script_vars;

// ****************************************************************************

$xml_objects[]['root'] = &$db_todo;
$xml_objects[]['root'] = &$dbworkitem_role;
$xml_objects[]['root'] = &$dbworkitem_user;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);
exit;

?>
