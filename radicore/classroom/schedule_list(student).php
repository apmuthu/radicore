<?php
// *****************************************************************************
// List the contents of a schedule (INNER table) for a selected occurrence of
// an OUTER table.
// *****************************************************************************

$outer_table = 'crs_student';                               // name of outer table
$inner_table = 'crs_schedule_s04';                          // name of inner table
$screen      = 'crs_schedule.list(student).screen.inc';     // file identifying screen structure

require 'std.list2.inc';        // activate page controller

?>
