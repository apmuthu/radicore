<?php 
// *****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
// *****************************************************************************

//DebugBreak();
$outer_table = 'crs_class';                             // name of outer table
$inner_table = 'crs_schedule_s03';                      // name of inner table
$screen      = 'crs_schedule.list(class).screen.inc';   // file identifying screen structure

require 'std.list2.inc';        // activate page controller

?>
