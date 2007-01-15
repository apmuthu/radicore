<?php
// *****************************************************************************
// Update the contents of a database table without any dialog with the user.
// *****************************************************************************

$table_id = '#tablename#';      // table name

// customise the SQL SELECT statement
$sql_select  = null;
$sql_from    = null;
$sql_where   = null;
$sql_groupby = null;
$sql_having  = null;

require_once 'std.add4.inc';    // activate page controller

?>
