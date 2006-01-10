<?php
//*****************************************************************************
// Allow occurrences of the STUDENT_LESSON table to be created. This links
// occurrences of the LESSON table with occurrences of the STUDENT table.
// The value for STUDENT_ID is passed from the previous screen while
// the list of one or more LESSON_IDs is provided by a separate popup screen.
//*****************************************************************************

//DebugBreak();
$table_id = 'crs_student_lesson';   // table name

$popup_screen = 'crs_lesson(popup)';

// activate page controller
require 'std.add3.inc';

?>

