<?php
//*****************************************************************************
// List the contents of a CHILD (inner) table for a particular value of the
// PARENT (outer) table (as selected in the previous screen) and allow the user
// to select one or more entries by means of a CHOOSE button.
//*****************************************************************************

//DebugBreak();
$outer_table = '#outer_table#';                     // name of outer (parent) table
$inner_table = '#inner_table#';                     // name of inner (child) table
$screen      = '#inner_table#.list2.screen.inc';    // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = '';
$outer_sql_from   = '';
$outer_sql_where  = '';

$inner_sql_select   = '';
$inner_sql_from     = '';
$inner_sql_where    = '';
$inner_sql_groupby  = '';
$inner_search_table = '';

require 'std.list2.popup.inc';            // activate page controller

?>
