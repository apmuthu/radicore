<?php
// *****************************************************************************
// List the contents of a schedule (INNER table) for a selected occurrence of
// an OUTER table.
// *****************************************************************************

$outer_table = 'crs_teacher';                               // name of outer table
$inner_table = 'crs_schedule_s02';                          // name of inner table
$screen      = 'crs_schedule.list(teacher).screen.inc';     // file identifying screen structure

// customise the SQL SELECT statement
$outer_sql_select  = "teacher_id, CONCAT(title, ' ', first_name, ' ', last_name) AS teacher_name";

require 'std.list2.inc';        // activate page controller

?>
