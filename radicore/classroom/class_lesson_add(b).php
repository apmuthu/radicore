<?php
//*****************************************************************************
// Allow occurrences of the CLASS_LESSON table to be created. This links
// occurrences of the LESSON table with occurrences of the CLASS table.
// The value for LESSON_ID is passed from the previous screen while
// the list of one or more CLASS_IDs is provided by a separate popup screen.
//*****************************************************************************

$table_id = 'crs_class_lesson';     // table name

$popup_task = 'crs_class(popup)';

require_once 'std.add3.inc';        // activate page controller

?>

