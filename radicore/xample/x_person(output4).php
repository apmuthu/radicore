<?php
//*****************************************************************************
// Extract the contents of a database table and export them to a CSV file which
// will be downloaded to the client device.
// The user is first asked which fields he would like included in the output.
//*****************************************************************************

$table_id = 'x_person';                      // table name
$screen   = 'x_person.output4.screen.inc';   // file identifying report structure

// customise the SQL SELECT statement
$sql_select  = null;
$sql_from    = null;
$sql_where   = null;
$sql_groupby = null;
$sql_having  = null;
$sql_orderby = null;

require 'std.output4.inc';      // activate page controller

?>
