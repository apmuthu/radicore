<?php
//*****************************************************************************
// This will allow occurrences of MANY in a ONE-to-MANY relationship to be
// displayed and modified.
// This version starts by showing the exiting entries, then allows the user
// to add, delete or modify entries.
// The primary key of  the ONE table is passed down from the previous screen.
//*****************************************************************************

$outer_table = 'survey_question';				// name of outer table
$inner_table = 'answer_option';                 // name of inner table
$screen   = 'answer_option.multi.screen.inc';   // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = 'survey_id,section_id,question_id,question_seq,question_text,answer_type';
$outer_sql_from   = NULL;
$outer_sql_where  = NULL;

$inner_sql_select = '';
$inner_sql_from   = '';
$inner_sql_where  = '';
$inner_sql_orderby = 'answer_seq';

require 'std.multi2.inc';       // activate page controller

?>
