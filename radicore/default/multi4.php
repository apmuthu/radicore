<?php
//*****************************************************************************
// This will display data from 2 tables in a ONE-to-MANY relationship.
// (also known as a PARENT-CHILD or OUTER-INNER relationship).
// It will start by reading the OUTER entity using the primary key passed down
// from the previous screen, then show existing occurrences of INNER.
// The data on the OUTER entity may be updated.
// Occurrences of INNER may then be modified, or added and deleted using the
// relevant buttons on the navigation bar.
//*****************************************************************************

$outer_table = '#outer_table#';				        // name of outer table
$inner_table = '#inner_table#';                     // name of inner table
$screen      = '#inner_table#.multi4.screen.inc';   // file identifying screen structure

// customise the SQL SELECT statement
$outer_sql_select  = null;
$outer_sql_from    = null;
$outer_sql_where   = null;
$outer_sql_groupby = null;
$outer_sql_having  = null;
$outer_sql_orderby = null;
$outer_sql_orderby_table = null;

$inner_sql_select   = null;
$inner_sql_from     = null;
$inner_sql_where    = null;
$inner_sql_groupby  = null;
$inner_sql_having   = null;
$inner_sql_orderby  = null;
$inner_search_table = null;

require 'std.multi4.inc';                           // activate page controller

?>