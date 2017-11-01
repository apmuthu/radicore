<?php
//*****************************************************************************
// This will allow occurrences of the INNER table to be displayed and modified.
// This version allows starts by showing the exiting entries, then allows the
// user to add, delete or modify entries.
// The identity of the OUTER table is passed down from the previous screen.
//*****************************************************************************

$outer_table = 'survey_question';			    // name of outer table
$inner_table = 'question_prompt';               // name of inner table
$screen   = 'question_prompt.list.screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = NULL;
$outer_sql_from   = NULL;
$outer_sql_where  = NULL;

$inner_sql_select = '*,prompt_desc';
$inner_sql_from   = 'question_prompt '
                   .'LEFT JOIN default_prompt ON (default_prompt.survey_id=question_prompt.survey_id AND default_prompt.prompt_id=question_prompt.prompt_id)';
$inner_sql_where  = '';
$inner_sql_orderby = '';

require 'std.list2.inc';        // activate page controller

?>
