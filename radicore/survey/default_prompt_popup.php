<?php
//*****************************************************************************
// List the contents of a database table and allow the user to choose one or
// more by pressing the CHOOSE button.
//*****************************************************************************

//DebugBreak();
$outer_table = 'survey_hdr';                     // outer table
$inner_table = 'default_prompt';   	             // inner table
$screen   = 'default_prompt.list.screen.inc';    // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = NULL;
$outer_sql_from   = NULL;
$outer_sql_where  = NULL;

$inner_sql_select = NULL;
$inner_sql_from   = NULL;
$inner_sql_where  = NULL;

// set default sort sequence
$inner_sql_orderby = NULL;

require 'std.list2.popup.inc';                  // activate page controller

?>
