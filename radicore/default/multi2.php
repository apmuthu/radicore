<?php
//*****************************************************************************
// This will allow occurrences of the INNER table to be displayed and modified.
// This version starts by showing the exiting entries, then allows the user
// to add, delete or modify entries.
// The identity of the parent/outer entry is passed down from the previous screen.
//*****************************************************************************

//DebugBreak();
$outer_table = '#outer_table#';				        // name of outer table
$inner_table = '#inner_table#';                     // name of inner table
$screen      = '#inner_table#.multi1.screen.inc';    // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = '';
$outer_sql_from   = '';
$outer_sql_where  = '';

$inner_sql_select   = '';
$inner_sql_from     = '';
$inner_sql_where    = '';
$inner_sql_groupby  = '';
$inner_search_table = '';

require 'std.multi2.inc';           // activate page controller

?>
