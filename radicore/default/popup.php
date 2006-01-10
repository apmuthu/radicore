<?php 
// *****************************************************************************
// List the contents of a database table and allow the user to choose one
// (or more) for processing by the previous screen.
// *****************************************************************************

//DebugBreak();
$table_id = '#tablename#';                  // table name
$screen   = '#tablename#.list.screen.inc';  // file identifying screen structure

// add 'choose' button to action bar
$act_buttons['choose'] = 'CHOOSE';

// identify extra parameters for a JOIN
$sql_select  = '';
$sql_from    = ''; 
$sql_where   = '';
$sql_groupby = '';

require 'std.list1.inc';            // activate page controller

?>
