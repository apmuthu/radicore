<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'wf_workflow';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 35);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 200);
$structure['main']['columns'][] = array('width' => 25);
$structure['main']['columns'][] = array('width' => 85);
$structure['main']['columns'][] = array('width' => 85);

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('workflow_id' => 'Id');
$structure['main']['fields'][] = array('workflow_name' => 'Process Name');
$structure['main']['fields'][] = array('start_task_id' => 'Starting Task');
$structure['main']['fields'][] = array('is_valid' => 'Valid?');
$structure['main']['fields'][] = array('start_date' => 'Start Date');
$structure['main']['fields'][] = array('end_date' => 'End Date');

?>