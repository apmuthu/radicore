<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'survey_hdr';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('survey_name' => 'Survey Name');

$structure['tables']['inner'] = 'survey_section';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 25);
$structure['inner']['columns'][] = array('width' => '*');

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('section_seq' => 'Seq');
$structure['inner']['fields'][] = array('section_name' => 'Name');

?>