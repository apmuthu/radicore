<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'survey_question';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => 10);
$structure['main']['columns'][] = array('width' => 50);
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][1][] = array('label' => 'Survey Id');
$structure['main']['fields'][1][] = array('field' => 'survey_id');
$structure['main']['fields'][1][] = array('label' => 'Name');
$structure['main']['fields'][1][] = array('field' => 'survey_name');

$structure['main']['fields'][2][] = array('label' => 'Section Id');
$structure['main']['fields'][2][] = array('field' => 'section_id');
$structure['main']['fields'][2][] = array('label' => 'Name');
$structure['main']['fields'][2][] = array('field' => 'section_name');

$structure['main']['fields'][] = array('question_seq' => 'Question', 'colspan' => 3);
$structure['main']['fields'][] = array('question_text' => 'Question Text', 'colspan' => 3);
$structure['main']['fields'][] = array('answer_type' => 'Answer Type', 'colspan' => 3);
$structure['main']['fields'][] = array('answer_list' => 'Answer Options', 'colspan' => 3);
$structure['main']['fields'][] = array('prompt_list' => 'Prompt List', 'colspan' => 3);
$structure['main']['fields'][] = array('advice_text' => 'Advice Text', 'colspan' => 3);
$structure['main']['fields'][] = array('risk_status_id' => 'Risk Status', 'colspan' => 3);

$structure['main']['fields'][] = array('created_date' => 'Created Date', 'colspan' => 3);
$structure['main']['fields'][] = array('created_user' => 'Created By', 'colspan' => 3);
$structure['main']['fields'][] = array('revised_date' => 'Revised Date', 'colspan' => 3);
$structure['main']['fields'][] = array('revised_user' => 'Revised By', 'colspan' => 3);

?>