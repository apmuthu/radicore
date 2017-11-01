<?php
// *****************************************************************************
// List the contents of the INNER table for a particular ID from the OUTER table
// (as selected in the previous screen) and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
// *****************************************************************************

$outer_table = 'mnu_pattern';               // name of outer table
$inner_table = 'mnu_task';                  // name of inner table
$screen = 'mnu_task.list2a.screen.inc';     // file identifying screen structure

require 'std.list2.inc';                    // activate page controller

?>
