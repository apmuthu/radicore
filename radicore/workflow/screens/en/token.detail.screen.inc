<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'wf_token';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('workflow_id' => 'Workflow');
$structure['main']['fields'][] = array('case_id' => 'Case Id');
$structure['main']['fields'][] = array('token_id' => 'Token Id');
$structure['main']['fields'][] = array('place_id' => 'Place Id');
$structure['main']['fields'][] = array('context' => 'Context');
$structure['main']['fields'][] = array('token_status' => 'Token Status');
$structure['main']['fields'][] = array('start_date' => 'Start Date');
$structure['main']['fields'][] = array('end_date' => 'End Date');
$structure['main']['fields'][] = array('enabled_date' => 'Enabled Date');
$structure['main']['fields'][] = array('cancelled_date' => 'Cancelled Date');
$structure['main']['fields'][] = array('consumed_date' => 'Consumed Date');

?>