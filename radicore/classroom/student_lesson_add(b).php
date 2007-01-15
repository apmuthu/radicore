<?php
//*****************************************************************************
// Allow occurrences of the STUDENT_LESSON table to be created. This links
// occurrences of the LESSON table with occurrences of the STUDENT table.
// The value for LESSON_ID is passed from the previous screen while
// the list of one or more STUDENT_IDs is provided by a separate popup screen.
//*****************************************************************************

$table_id = 'crs_student_lesson';   // table name

$popup_task = 'crs_student(popup)';

require 'std.add3.inc';             // activate page controller

?>

