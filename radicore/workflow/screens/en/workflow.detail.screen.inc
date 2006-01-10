<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'wf_workflow';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('workflow_id' => 'Workflow Id');
$structure['main']['fields'][] = array('workflow_name' => 'Workflow Name');
$structure['main']['fields'][] = array('workflow_desc' => 'Description');
$structure['main']['fields'][] = array('start_task_id' => 'Starting Task');
$structure['main']['fields'][] = array('is_valid' => 'Valid?');
$structure['main']['fields'][] = array('workflow_errors' => 'Errors');
$structure['main']['fields'][] = array('start_date' => 'Start Date');
$structure['main']['fields'][] = array('end_date' => 'End Date');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>