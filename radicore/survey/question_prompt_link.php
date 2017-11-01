<?php
//*****************************************************************************
// This will allow an occurrences of the LINK table to be added or deleted.
// The identity of the OUTER occurrence is passed down from the previous screen.
// The INNER table is defined using LEFT JOIN from within the LINK table.
// The existence of individual LINK table entries will be shown in a checkbox
// which can be toggled ON to create a record or OFF to delete a record.
//*****************************************************************************

$outer_table = 'survey_question';			    // name of outer table
$link_table  = 'question_prompt';           	// name of link table
$inner_table = 'default_prompt';                // name of inner table
$screen   = 'question_prompt.link.screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = 'survey_question.survey_id,survey_name,'.
                    'survey_question.section_id,section_name,'.
                    'survey_question.question_id,question_text,'.
                    'survey_question.question_seq';
$outer_sql_from   = 'survey_question '.
                    'LEFT JOIN survey_hdr ON (survey_hdr.survey_id=survey_question.survey_id) '.
                    'LEFT JOIN survey_section ON (survey_section.survey_id=survey_question.survey_id AND survey_section.section_id=survey_question.section_id)';
$outer_sql_where  = NULL;

// modify the sql select for the LINK table
$link_sql_select = 'survey_question.question_seq, prompt_desc';
$link_sql_from   = '';
$link_sql_where  = 'default_prompt.survey_id=survey_question.survey_id';

require 'std.link1.inc';        // activate page controller

?>
