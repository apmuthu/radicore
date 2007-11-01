<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2007 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.output2.inc

// type = output2

// This will output the contents a database table to a PDF file (LIST view)
// then download it to the client device.

// Note that there is no dialog with the user (apart from the download box)

require_once 'include.general.inc';

// identify output mode
$mode = 'pdf-list';

// load session variables
initSession();

if (!empty($selection) AND !isset($return_from)) {
    // $selection takes precedence over $where
    $where     = $selection;
    $selection = null;
} // if

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
} elseif (isset($task_orderby)) {
    $dbobject->setDefaultOrderby($task_orderby);
} // if
// set sort order (if defined)
if (!empty($orderby)) {
    $string = validateSortItem('body', $orderby, $dbobject, $report_structure);
    $dbobject->setOrderBy($string);
    if (!empty($orderby_seq)) {
        $dbobject->setOrderBySeq($orderby_seq);
    } // if
} // if
// perform any initialisation
$where = $dbobject->initialise($where);
if (empty($dbobject->errors)) {
	// get any data for lookup lists
    $null = $dbobject->getExtraData($where);
} // if
if ($dbobject->errors) {
	scriptPrevious($dbobject->errors);
} // if

// load optional criteria from search screen
if (isset($search)) {
    $dbobject->setSqlSearch($search);
} // if

// get data from the database
$resource = $dbobject->getData_serial($where);
if (!empty($dbobject->errors)) {
	scriptPrevious($dbobject->errors);
} // if

if ($dbobject->getNumRows() == 0) {
    scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
} // if

// transform output to PDF format and deal with it as specified in $report
$destination = $dbobject->outputPDF_ListView($resource, $report_structure);

$messages = $dbobject->messages;
$errors   = $dbobject->errors;

$prev_script = getPreviousScript($task_id);
$prev_task   = getPreviousTask($prev_script);
// tell previous script that we are returning
$_SESSION[$prev_script][$prev_task]['return_from'] = 'pdf';

if (!eregi('(D|I)', $destination) OR !empty($errors)) {
	scriptPrevious($errors, $messages);
} else {
    unset($_SESSION[getSelf()]);  // delete current script from session array
} // if

exit;
?>
