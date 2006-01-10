<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'default_prompt';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('survey_name' => 'Survey Name');
$structure['main']['fields'][] = array('prompt_id' => 'Prompt Id');
$structure['main']['fields'][] = array('prompt_desc' => 'Description');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>