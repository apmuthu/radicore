<?php
//*****************************************************************************
// Extract the contents of a database table in a Tree View and export them to a
// CSV file which will be downloaded to the client device.
//*****************************************************************************

$table_id = '#tablename#';      // table name

// customise the SQL SELECT statement
$sql_select  = null;
$sql_from    = null;
$sql_where   = null;
$sql_groupby = null;
$sql_having  = null;
$sql_orderby = null;

require 'std.output6.inc';      // activate page controller

?>
