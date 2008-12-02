<?php
//*****************************************************************************
// Allow new occurrences to be added to a database table as a child records
// to an existing parent. The primary key of the parent is selected in the
// previous screen.
//*****************************************************************************

$outer_table = '#outer_table#';                 // outer table name
$inner_table = '#inner_table#';                 // inner table name
$screen   = '#inner_table#.add5.screen.inc';    // file identifying screen structure

// customise the SQL SELECT statement
$outer_sql_select  = null;
$outer_sql_from    = null;
$outer_sql_where   = null;
$outer_sql_groupby = null;
$outer_sql_having  = null;
$outer_sql_orderby = null;
$outer_sql_orderby_table = null;

require 'std.add5.inc';     // activate page controller

?>
