<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2007 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.output3.inc

// type = output3

// This will output the contents a database table to a PDF file (DETAIL view)
// then download it to the client device.

// Note that there is no dialog with the user (apart from the download box)

require_once 'include.general.inc';

// identify output mode
$mode = 'pdf-detail';

//ini_set('max_execution_time', 60);

// load session variables
initSession();

// create a class instance of the main database table
require_once "classes/$table_id.class.inc";
$dbobject = new $table_id;
$dbobject->sql_select  = &$sql_select;
$dbobject->sql_from    = &$sql_from;
$dbobject->sql_where   = &$sql_where;
$dbobject->sql_groupby = &$sql_groupby;
$dbobject->sql_having  = &$sql_having;
if (!empty($sql_orderby)) {
    $dbobject->setDefaultOrderby($sql_orderby);
} elseif (isset($task_order_by)) {
    $dbobject->setDefaultOrderby($task_order_by);
} // if
// set sort order (if defined)
if (!empty($order_by)) {
    $string = validateSortItem('body', $order_by, $dbobject, $report_structure);
    $dbobject->setOrderBy($string);
    if (!empty($order_by_seq)) {
        $dbobject->setOrderBySeq($order_by_seq);
    } // if
} // if
// perform any initialisation
if (!empty($selection)) {
    $selection = $dbobject->initialise($selection);
} else {
    $where = $dbobject->initialise($where);
} // if
// get any data for lookup lists
$null = $dbobject->getExtraData(null);

// load optional criteria from search screen
if (isset($search)) {
    $dbobject->setSqlSearch($search);
} // if

if (!empty($selection)) {
    // retrieve profile has been set by previous screen
    $where     = $selection;
    $selection = null;
} // if

// get data from the database
$resource = $dbobject->getData_serial($where);
$errors   = $dbobject->getErrors();
if (!empty($errors)) {
	scriptPrevious($errors);
} // if

if ($dbobject->getNumRows() == 0) {
    scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
} // if

// transform output to PDF format and deal with it as specified in $report
$destination = $dbobject->outputPDF_DetailView($resource, $report_structure);

$prev_script = getPreviousScript($task_id);
$prev_task   = getPreviousTask($prev_script);
// tell previous script that we are returning
$_SESSION[$prev_script][$prev_task]['return_from'] = 'pdf';

if ($destination == 'F') {
	scriptPrevious();
} else {
    unset($_SESSION[getSelf()]);  // delete current script from session array
} // if

exit;
?>