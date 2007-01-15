<?php
// *****************************************************************************
// List the contents of a database table and allow the user to select one or
// more entries by means of a CHOOSE button.
// *****************************************************************************

$table_id = 'crs_schedule_hdr_s01';             // table name
$screen   = 'crs_schedule_hdr.list.screen.inc'; // file identifying screen structure

// customise the SQL SELECT statement
$sql_select  = null;
$sql_from    = null;
$sql_where   = null;
$sql_groupby = null;
$sql_having  = null;
$sql_orderby = null;

require 'std.list1.popup.inc';                  // activate page controller

?>
