<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'wf_workflow';

$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => 100);
$structure['outer']['columns'][] = array('width' => 100);
$structure['outer']['columns'][] = array('width' => '*');

$structure['outer']['fields'][1][] = array('label' => 'Workflow Id');
$structure['outer']['fields'][1][] = array('field' => 'workflow_id');
$structure['outer']['fields'][1][] = array('label' => 'Name');
$structure['outer']['fields'][1][] = array('field' => 'workflow_name');

$structure['tables']['inner'] = 'wf_case';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 50);
$structure['inner']['columns'][] = array('width' => 75);
$structure['inner']['columns'][] = array('width' => 150);
$structure['inner']['columns'][] = array('width' => 150);
$structure['inner']['columns'][] = array('width' => '*');

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('case_id' => 'Id');
$structure['inner']['fields'][] = array('case_status' => 'Status');
$structure['inner']['fields'][] = array('start_date' => 'Start Date');
$structure['inner']['fields'][] = array('end_date' => 'End Date');
$structure['inner']['fields'][] = array('blank' => '');

?>