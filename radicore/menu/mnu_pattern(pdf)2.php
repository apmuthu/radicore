<?php
//*****************************************************************************
// Extract the contents of a database table and export them to a PDF file which
// will be downloaded to the client device.
//*****************************************************************************

$table_id = 'mnu_pattern';                     // table name
$report   = 'mnu_pattern.detail.report.inc';   // file identifying report structure

// customise the SQL SELECT statement
$sql_select  = null;
$sql_from    = null;
$sql_where   = null;
$sql_groupby = null;
$sql_having  = null;
$sql_orderby = null;

require 'std.output3.inc';      // activate page controller

?>
