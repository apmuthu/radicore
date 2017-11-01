<?php
//*****************************************************************************
// This will allow occurrences of the OUTER database table to be deleted, as well
// as all related occurrences on the INNER table.
// The identity of the selected OUTER occurrence(s) is passed from the previous screen.
//*****************************************************************************

$outer_table = '#outer_table#';                     // name of outer (parent) table
$inner_table = '#inner_table#';                     // name of inner (child) table
$screen      = '#inner_table#.del4.screen.inc';     // file identifying screen structure

// customise the SQL SELECT statement
$outer_sql_select  = null;
$outer_sql_from    = null;
$outer_sql_where   = null;
$outer_sql_groupby = null;
$outer_sql_having  = null;
$outer_sql_orderby = null;
$outer_sql_sort_table = null;

$inner_sql_select   = null;
$inner_sql_from     = null;
$inner_sql_where    = null;
$inner_sql_groupby  = null;
$inner_sql_having   = null;
$inner_sql_orderby  = null;
$inner_search_table = null;

require 'std.delete4.inc';            // activate page controller

?>
