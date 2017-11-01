<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'wf_case';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 25);
$structure['main']['columns'][] = array('width' => 25);
$structure['main']['columns'][] = array('width' => 150);
$structure['main']['columns'][] = array('width' => 150);

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('workflow_name' => 'Workflow Name');
$structure['main']['fields'][] = array('case_id' => 'Id');
$structure['main']['fields'][] = array('case_status' => 'Status');
$structure['main']['fields'][] = array('start_date' => 'Start Date');
$structure['main']['fields'][] = array('end_date' => 'End Date');

?>