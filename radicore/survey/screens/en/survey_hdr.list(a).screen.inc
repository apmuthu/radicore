<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'survey_type';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('survey_type_desc' => 'Survey Type');

$structure['tables']['inner'] = 'survey_hdr';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 150);
$structure['inner']['columns'][] = array('width' => 350);

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('survey_name' => 'Name');
$structure['inner']['fields'][] = array('survey_desc' => 'Description');

?>