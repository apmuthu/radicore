<?php 
// *****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
// *****************************************************************************

//DebugBreak();
$outer_table = 'crs_schedule_hdr';              // name of outer table
$inner_table = 'crs_schedule';                  // name of inner table
$screen      = 'crs_schedule.list.screen.inc';  // file identifying screen structure

// activate page controller
require 'std.list2.inc';

?>
