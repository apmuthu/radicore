<?php
//*****************************************************************************
// This will allow occurrences of the INNER table to be displayed and modified.
// This version starts by showing the exiting entries, then allows the user
// to add, delete or modify entries.
// The identity of the OUTER table is passed down from the previous screen.
//*****************************************************************************

//DebugBreak();
$outer_table = 'product';				        // name of outer table
$inner_table = 'prod_cat_class';                // name of inner table
$screen = 'prod_cat_class.list.screen.inc';     // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = 'product_id,product_name';
$outer_sql_from   = NULL;
$outer_sql_where  = NULL;

$inner_sql_select = '';
$inner_sql_from   = '';
$today = date('Y-m-d');
$inner_sql_where  = "start_date<='$today' AND end_date>='$today'";

// set default sort sequence
$inner_sql_orderby = '';

// activate page controller
require 'std.list2.inc';

?>
