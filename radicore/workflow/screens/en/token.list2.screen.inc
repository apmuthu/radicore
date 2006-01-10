<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'wf_case';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('workflow_name' => 'Workflow Name');
$structure['outer']['fields'][] = array('case_id' => 'Case Id');

$structure['tables']['inner'] = 'wf_token';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 50);
$structure['inner']['columns'][] = array('width' => 50);
$structure['inner']['columns'][] = array('width' => 75);
$structure['inner']['columns'][] = array('width' => 150);
$structure['inner']['columns'][] = array('width' => 150);
$structure['inner']['columns'][] = array('width' => '*');

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('token_id' => 'Token Id');
$structure['inner']['fields'][] = array('place_name' => 'Place');
$structure['inner']['fields'][] = array('token_status' => 'Status');
$structure['inner']['fields'][] = array('enabled_date' => 'Enabled Date');
$structure['inner']['fields'][] = array('consumed_date' => 'Consumed Date');
$structure['inner']['fields'][] = array('blank' => '');

?>