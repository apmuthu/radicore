<?php
//*****************************************************************************
// List the contents of the INNER table for a particular ID on the OUTER table
// (as selected in the previous screen) and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

$outer_table = 'mnu_task';                      // name of outer table
$inner_table = 'mnu_task_field';                // name of inner table
$screen = 'mnu_task_field.list.screen.inc';     // file identifying screen structure

require 'std.list2.inc';                        // activate page controller

?>
