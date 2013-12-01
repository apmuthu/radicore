<?php
//*****************************************************************************
// This will use the top (outer) zone to enter selection criteria which will be
// passed to the bottom (inner) zone so that it can retrieve and display those
// database rows which satisfy that selection criteria.
//
// By default the bottom zone is amendable, but can be made read-only.
//*****************************************************************************

$outer_table = '#outer_table#';				        // name of outer table
$inner_table = '#inner_table#';                     // name of inner table
$screen      = '#inner_table#.multi5.screen.inc';   // file identifying screen structure

// customise the SQL SELECT statement
$inner_sql_select   = null;
$inner_sql_from     = null;
$inner_sql_where    = null;
$inner_sql_groupby  = null;
$inner_sql_having   = null;
$inner_sql_orderby  = null;
$inner_search_table = null;

require 'std.multi5.inc';                           // activate page controller

?>