<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'wf_token';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 25);
$structure['main']['columns'][] = array('width' => 25);
$structure['main']['columns'][] = array('width' => 25);
$structure['main']['columns'][] = array('width' => 25);
$structure['main']['columns'][] = array('width' => 150);
$structure['main']['columns'][] = array('width' => 150);

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('workflow_name' => 'Workflow Name');
$structure['main']['fields'][] = array('case_id' => 'Case Id');
$structure['main']['fields'][] = array('token_id' => 'Token Id');
$structure['main']['fields'][] = array('place_name' => 'Place');
$structure['main']['fields'][] = array('token_status' => 'Status');
$structure['main']['fields'][] = array('enabled_date' => 'Enabled Date');
$structure['main']['fields'][] = array('consumed_date' => 'Consumed Date');

?>