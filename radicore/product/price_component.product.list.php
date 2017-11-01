<?php
//*****************************************************************************
// This will allow occurrences of the INNER table to be displayed and modified.
// This version starts by showing the exiting entries, then allows the user
// to add, delete or modify entries.
// The identity of the OUTER table is passed down from the previous screen.
//*****************************************************************************

$outer_table = 'product';				                // name of outer table
$inner_table = 'price_component';                       // name of inner table
$screen = 'price_component.product.list.screen.inc';    // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = 'product_id,product_name';
$outer_sql_from   = NULL;
$outer_sql_where  = NULL;

$inner_sql_select = '';
$inner_sql_from   = '';
$inner_sql_where  = '';

require 'std.list2.inc';            // activate page controller

?>
