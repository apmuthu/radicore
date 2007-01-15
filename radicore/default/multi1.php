<?php
//*****************************************************************************
// This will allow a database record table to be updated, or inserted if it does
// not currently exist.
// The identity of the selected record is passed down in $where.
//*****************************************************************************

$table_id = '#tablename#';                     // table id
$screen   = '#tablename#.detail.screen.inc';   // file identifying screen structure

// customise the SQL SELECT statement
$sql_select  = null;
$sql_from    = null;
$sql_where   = null;
$sql_groupby = null;
$sql_having  = null;
$sql_orderby = null;
$sql_orderby_table = null;

// define action buttons
$act_buttons['clear'] = 'CLEAR';

require 'std.multi1.inc';           // activate page controller

?>
