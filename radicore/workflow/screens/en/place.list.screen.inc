<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'wf_workflow';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('workflow_name' => 'Workflow Name');

$structure['tables']['inner'] = 'wf_place';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => '*');

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('place_name' => 'Place Name');

?>