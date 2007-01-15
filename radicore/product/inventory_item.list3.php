<?php
//*****************************************************************************
// List the contents of a CHILD (inner) table for a particular value of the
// PARENT (outer) table (as selected in the previous screen) and allow the user
// to view/modify entries by activating other screens via navigation buttons.
//*****************************************************************************

$outer_table = 'facility';                           // name of outer (parent) table
$inner_table = 'inventory_item';                     // name of inner (child) table
$screen      = 'inventory_item.list3.screen.inc';    // file identifying screen structure

// customise the SQL SELECT statement
$inner_sql_select   = 'inventory_item.*, product.product_name, unit_of_measure.uom_abbrev ';
$inner_sql_from     = 'inventory_item '
                    . 'LEFT JOIN product ON (product.product_id=inventory_item.product_id) '
                    . 'LEFT JOIN unit_of_measure ON (unit_of_measure.uom_id=product.uom_id) ';
$inner_sql_where    = null;
$inner_sql_groupby  = null;
$inner_sql_having   = null;
$inner_sql_orderby  = null;
$inner_search_table = null;

require 'std.list2.inc';                        // activate page controller

?>
