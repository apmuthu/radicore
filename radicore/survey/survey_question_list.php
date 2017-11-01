<?php
//*****************************************************************************
// This will allow occurrences of the INNER table to be displayed and modified.
// This version allows starts by showing the exiting entries, then allows the
// user to add, delete or modify entries.
// The identity of the OUTER table is passed down from the previous screen.
//*****************************************************************************

$outer_table = 'survey_section';				// name of outer table
$inner_table = 'survey_question';               // name of inner table
$screen   = 'survey_question.list.screen.inc';  // file identifying screen structure

require 'std.list2.inc';        // activate page controller

?>
