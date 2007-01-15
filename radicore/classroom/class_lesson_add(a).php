<?php
//*****************************************************************************
// Allow occurrences of the CLASS_LESSON table to be created. This links
// occurrences of the LESSON table with occurrences of the CLASS table.
// The value for CLASS_ID is passed from the previous screen while
// the list of one or more LESSON_IDs is provided by a separate popup screen.
//*****************************************************************************

$table_id = 'crs_class_lesson';     // table name

$popup_task = 'crs_lesson(popup)';

require_once 'std.add3.inc';        // activate page controller

?>

