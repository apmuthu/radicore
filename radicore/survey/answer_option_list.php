<?php
//*****************************************************************************
// This will allow occurrences of the INNER table to be displayed and modified.
// This version allows starts by showing the exiting entries, then allows the
// user to add, delete or modify entries.
// The identity of the OUTER table is passed down from the previous screen.
//*****************************************************************************

$outer_table = 'survey_question';			    // name of outer table
$inner_table = 'answer_option';                 // name of inner table
$screen   = 'answer_option.list.screen.inc';    // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = NULL;
$outer_sql_from   = NULL;
$outer_sql_where  = NULL;

$inner_sql_select = '';
$inner_sql_from   = '';
$inner_sql_where  = '';
$inner_sql_orderby = '';

require 'std.list2.inc';        // activate page controller

?>
