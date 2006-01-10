<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'survey_hdr';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('survey_name' => 'Survey Name');

$structure['tables']['inner'] = 'default_prompt';

$structure['inner']['columns'][] = array('width' => 5);

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('prompt_desc' => 'Description');

?>