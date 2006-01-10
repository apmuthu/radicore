<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'survey_answer_hdr';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 100);
$structure['main']['columns'][] = array('width' => 90);
$structure['main']['columns'][] = array('width' => 100);
$structure['main']['columns'][] = array('width' => 150);

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('user_name' => 'User Name');
$structure['main']['fields'][] = array('answer_date' => 'Date');
$structure['main']['fields'][] = array('node_desc' => 'Location');
$structure['main']['fields'][] = array('survey_name' => 'Survey');
$structure['main']['fields'][] = array('is_complete' => 'Done?');

?>