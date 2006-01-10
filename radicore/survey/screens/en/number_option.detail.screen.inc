<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'number_option';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('survey_name' => 'Survey Name');
$structure['main']['fields'][] = array('section_id' => 'Section Id');
$structure['main']['fields'][] = array('section_seq' => 'Section Seq');
$structure['main']['fields'][] = array('section_name' => 'Section Name');
$structure['main']['fields'][] = array('question_seq' => 'Question');
$structure['main']['fields'][] = array('question_text' => 'Question Text');
$structure['main']['fields'][] = array('min_value' => 'Minimum Value');
$structure['main']['fields'][] = array('max_value' => 'Maximum Value');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>