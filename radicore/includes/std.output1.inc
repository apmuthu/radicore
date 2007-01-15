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
    $string = validateSortItem('', $order_by, $dbobject);
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

if ($dbobject->getNumRows() == 0) {
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
