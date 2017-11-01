<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'survey_answer_hdr';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('survey_answer_id' => 'Id');
$structure['main']['fields'][] = array('user_id' => 'User');
$structure['main']['fields'][] = array('survey_id' => 'Survey');
$structure['main']['fields'][] = array('answer_date' => 'Date');
$structure['main']['fields'][] = array('node_id' => 'Location');
$structure['main']['fields'][] = array('is_complete' => 'Completed?');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>