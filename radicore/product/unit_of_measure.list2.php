<?php
//*****************************************************************************
// List the contents of a CHILD (inner) table for a particular value of the
// PARENT (outer) table (as selected in the previous screen) and allow the user
// to view/modify entries by activating other screens via navigation buttons.
//*****************************************************************************

$outer_table = 'uom_category';                      // name of outer (parent) table
$inner_table = 'unit_of_measure';                   // name of inner table
$screen      = 'unit_of_measure.list2.screen.inc';  // file identifying screen structure

require 'std.list2.inc';                            // activate page controller

?>
