<?php
//*****************************************************************************
// List the contents of a CHILD (inner) table for a particular value of the
// PARENT (outer) table (as selected in the previous screen) and allow the user
// to view/modify entries by activating other screens via navigation buttons.
//*****************************************************************************

$outer_table = 'product';                            // name of outer (parent) table
$inner_table = 'inventory_item';                     // name of inner (child) table
$screen      = 'inventory_item.list2.screen.inc';    // file identifying screen structure

require 'std.list2.inc';                        // activate page controller

?>
