<?php
//*****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

$outer_table = 'inventory_item';                              // name of outer (parent) table
$inner_table = 'inventory_item_variance';                     // name of inner (child) table
$screen      = 'inventory_item_variance.list2.screen.inc';    // file identifying screen structure

// customise the SQL SELECT statement
//$outer_sql_select  = '*, qty_on_hand - total_qty AS variance_qty ';
//$outer_sql_from    = null;

require 'std.list2.inc';                        // activate page controller

?>
