<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'survey_answer_dtl';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 10);
$structure['main']['columns'][] = array('width' => '75%');

$structure['main']['fields'][1][] = array('label' => 'Survey Id');
$structure['main']['fields'][1][] = array('field' => 'survey_id');
$structure['main']['fields'][1][] = array('label' => 'Name');
$structure['main']['fields'][1][] = array('field' => 'survey_name');

$structure['main']['fields'][2] = array('user_name' => 'User Name', 'colspan' => 3);
$structure['main']['fields'][3] = array('answer_date' => 'Answer Date', 'colspan' => 3);
$structure['main']['fields'][4] = array('node_desc' => 'Location', 'colspan' => 3);

$structure['main']['fields'][5][] = array('label' => 'Section');
$structure['main']['fields'][5][] = array('field' => 'section_id');
$structure['main']['fields'][5][] = array('field' => 'section_name', 'colspan' => 2);

$structure['main']['fields'][6][] = array('label' => 'Question');
$structure['main']['fields'][6][] = array('field' => 'question_id');
$structure['main']['fields'][6][] = array('field' => 'question_text', 'colspan' => 2);

$structure['main']['fields'][7] = array('answer_text' => 'Present Measure', 'colspan' => 3);
$structure['main']['fields'][8] = array('weighting_id' => 'Risk Weighting', 'colspan' => 3);
$structure['main']['fields'][9] = array('measure_adequate' => 'Is Present Measure adequate?', 'colspan' => 3);
$structure['main']['fields'][10] = array('advice_text' => 'Policy or Advice', 'colspan' => 3);
$structure['main']['fields'][11] = array('prompt_list' => 'Prompt List', 'colspan' => 3);

$structure['main']['fields'][] = array('created_date' => 'Created Date', 'colspan' => 3);
$structure['main']['fields'][] = array('created_user' => 'Created By', 'colspan' => 3);
$structure['main']['fields'][] = array('revised_date' => 'Revised Date', 'colspan' => 3);
$structure['main']['fields'][] = array('revised_user' => 'Revised By', 'colspan' => 3);

?>