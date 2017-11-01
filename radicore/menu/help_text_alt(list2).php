<?php
//*****************************************************************************
// List the contents of a CHILD (inner) table for a particular value of the
// PARENT (outer) table (as selected in the previous screen) and allow the user
// to view/modify entries by activating other screens via navigation buttons.
//*****************************************************************************

$outer_table = 'help_text';                         // name of outer (parent) table
$inner_table = 'help_text_alt';                     // name of inner (child) table
$screen      = 'help_text_alt.list2.screen.inc';    // file identifying screen structure

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
$inner_sql_orderby_table = null;
$inner_search_table = '';

require 'std.list2.inc';            // activate page controller

?>
