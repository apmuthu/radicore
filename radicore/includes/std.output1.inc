<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2007 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.output1.inc

// type = output1

// This will output the contents a database table to a CSV file, then download
// it to the client device.

// Note that there is no dialog with the user (apart from the download box)

require_once 'include.general.inc';

// identify output mode
$mode = 'csv';

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
// indicate that this object was started from a page controller
$dbobject->initiated_from_controller = true;
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

// perform any initialisation
$where = $dbobject->initialise($where);
if (empty($dbobject->errors)) {
	// get any data for lookup lists
    $null = $dbobject->getExtraData($where);
} else {
	scriptPrevious($dbobject->errors);
} // if

// set sort order (if defined)
if (!empty($orderby)) {
    $string = validateSortItem('', $orderby, $dbobject);
    $dbobject->setOrderBy($string);
    if (!empty($orderby_seq)) {
        $dbobject->setOrderBySeq($orderby_seq);
    } // if
} // if

// load optional criteria from search screen
if (isset($search)) {
    $dbobject->setSqlSearch($search);
} // if

// get data from the database
$resource = $dbobject->getData_serial($where);

if ($dbobject->getNumRows() <= 0) {
    scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
} // if

// transform output to CSV format and download to client browser
$output = $dbobject->outputCSV($resource);

header("Content-type: text/comma-separated-values");
header('Expires: ' . gmdate('D, d M Y H:i:s') . ' GMT');
header("Content-Disposition: attachment; filename=" .$table_id .'.csv');
header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
header('Pragma: public');
echo $output;

unset($_SESSION[getSelf()]);
exit;
?>
