<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'survey_hdr';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 300);
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('survey_name' => 'Name');
$structure['main']['fields'][] = array('survey_long_name' => 'Long Name');

?>