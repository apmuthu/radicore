<?php
//*****************************************************************************
// This will allow an occurrences of the LINK table to be added or deleted.
// The identity of the OUTER occurrence is passed down from the previous screen.
// The INNER table is defined using LEFT JOIN from within the LINK table.
// The existence of individual LINK table entries will be shown in a checkbox
// which can be toggled ON to create a record or OFF to delete a record.
//*****************************************************************************

$outer_table = '#outer_table#';      		    // name of outer table
$link_table  = '#link_table#';      	        // name of link table
$inner_table = '#inner_table#';                 // name of inner table
$screen      = '#link_table#.link.screen.inc';  // file identifying screen structure

// customise the SQL SELECT statement
$outer_sql_select  = null;
$outer_sql_from    = null;
$outer_sql_where   = null;
$outer_sql_groupby = null;
$outer_sql_having  = null;
$outer_sql_orderby = null;
$outer_sql_sort_table = null;

$link_sql_select  = null;
$link_sql_from    = null;
$link_sql_where   = null;
$link_sql_groupby = null;
$link_sql_having  = null;
$link_sql_orderby = null;
$link_search_table = null;

require 'std.link1.inc';            // activate page controller

?>
