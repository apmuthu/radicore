<?php
//*****************************************************************************
// Allow occurrences of an xref/link database table to be created.
// This links occurrences of two other tables.
// The value for one of these other tables is passed from the previous screen
// while values for the other are selected from a separate popup screen.
//*****************************************************************************

//DebugBreak();
$table_id = 'question_prompt';       	   // table name

$popup_screen = 'srv_default_prompt(popup)';

// activate page controller
require 'std.add3.inc';

?>

