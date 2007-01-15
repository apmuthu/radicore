<?php
//*****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

$outer_table = 'inventory_item';                                 // name of outer (parent) table
$inner_table = 'inventory_item_status_hist';                     // name of inner (child) table
$screen      = 'inventory_item_status_hist.list2.screen.inc';    // file identifying screen structure

require 'std.list2.inc';                        // activate page controller

?>
