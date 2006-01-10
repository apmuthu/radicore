<?php
//*****************************************************************************
// Allow occurrences of the CLASS_LESSON table to be created. This links
// occurrences of the LESSON table with occurrences of the CLASS table.
// The value for CLASS_ID is passed from the previous screen while
// the list of one or more LESSON_IDs is provided by a separate popup screen.
//*****************************************************************************

//DebugBreak();
$table_id = 'crs_class_lesson';   // table name

$popup_screen = 'crs_lesson(popup)';

// activate page controller
require 'std.add3.inc';

?>

