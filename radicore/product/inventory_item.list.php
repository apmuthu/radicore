<?php
//*****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

$table_id = 'inventory_item';                    // table name
$screen   = 'inventory_item.list.screen.inc';    // file identifying screen structure

// customise the SQL SELECT statement
$sql_select  = 'inventory_item.*, product.product_name, unit_of_measure.uom_abbrev ';
$sql_from    = 'inventory_item '
             . 'LEFT JOIN product ON (product.product_id=inventory_item.product_id) '
             . 'LEFT JOIN unit_of_measure ON (unit_of_measure.uom_id=product.uom_id) ';
$sql_where   = null;
$sql_groupby = null;
$sql_having  = null;
$sql_orderby = null;

require 'std.list1.inc';                        // activate page controller

?>
