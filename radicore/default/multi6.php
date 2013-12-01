<?php
//*****************************************************************************
// This will use the top (outer) zone to enter selection criteria which will be
// passed to the bottom (middle and inner) zones so that it can retrieve and display
// those database rows which satisfy that selection criteria.
//
// By default the bottom zone is amendable, but can be made read-only.
//*****************************************************************************

$outer_table  = '#outer_table#';				     // name of outer table
$middle_table = '#middle_table#';                    // name of middle table
$inner_table  = '#inner_table#';                     // name of inner table
$screen       = '#inner_table#.multi6.screen.inc';   // file identifying screen structure

// customise the SQL SELECT statement
$middle_sql_select  = null;
$middle_sql_from    = null;
$middle_sql_where   = null;
$middle_sql_groupby = null;
$middle_sql_having  = null;
$middle_sql_orderby = null;

$inner_sql_select   = null;
$inner_sql_from     = null;
$inner_sql_where    = null;
$inner_sql_groupby  = null;
$inner_sql_having   = null;
$inner_sql_orderby  = null;
$inner_search_table = null;

require 'std.multi6.inc';                            // activate page controller

?>