<?php
//*****************************************************************************
// Read an entry from the PARENT (outer) table (as selected in the previous screen),
// then read one or more entries from the CHILD (middle) table showing them one at a
// time, then read multiple entries from the GRANDCHILD (inner) table and allow the
// user to view/modify entries by activating other screens via navigation buttons.
//*****************************************************************************

$outer_table  = '#outer_table#';                     // name of outer (parent) table
$middle_table = '#middle_table#';                    // name of middle (child) table
$inner_table  = '#inner_table#';                     // name of inner (grandchild) table
$screen       = '#inner_table#.list3.screen.inc';    // file identifying screen structure

// customise the SQL SELECT statement
$outer_sql_select  = null;
$outer_sql_from    = null;
$outer_sql_where   = null;
$outer_sql_groupby = null;
$outer_sql_having  = null;
$outer_sql_orderby = null;
$outer_sql_orderby_table = null;

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

require 'std.list3.inc';            // activate page controller

?>
