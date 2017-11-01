<?php
// *****************************************************************************
// List the contents of a database table and allow the user to select one or
// more entries by means of a CHOOSE button.
// *****************************************************************************

$table_id = '#tablename#';                      // table name
$screen   = '#tablename#.popup1.screen.inc';    // file identifying screen structure

// customise the SQL SELECT statement
$sql_select  = null;
$sql_from    = null;
$sql_where   = null;
$sql_groupby = null;
$sql_having  = null;
$sql_orderby = null;

require 'std.list1.popup.inc';                  // activate page controller

?>
