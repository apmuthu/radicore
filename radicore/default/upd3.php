<?php
//*****************************************************************************
// This will allow occurrences of a CONTROL table to be created/updated.
// Although this table has a simple structure (record_id, field_id, field_value)
// what is shown on the screen is a customisable selection of field names and
// field values.
//*****************************************************************************

$table_id = "#tablename#";                   // table id
$screen   = '#tablename#.detail.screen.inc'; // file identifying screen structure

// customise the SQL SELECT statement
$sql_select  = null;
$sql_from    = null;
$sql_where   = null;
$sql_groupby = null;
$sql_having  = null;

require 'std.update3.inc';          // activate page controller

?>
