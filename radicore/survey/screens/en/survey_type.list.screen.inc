<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'survey_type';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 70);
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('survey_type_id' => 'Id');
$structure['main']['fields'][] = array('survey_type_desc' => 'Description');

?>