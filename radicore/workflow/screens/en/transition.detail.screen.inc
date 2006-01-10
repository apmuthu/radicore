<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'wf_transition';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('workflow_id' => 'Workflow Id');
$structure['main']['fields'][] = array('workflow_name' => 'Workflow Name');
$structure['main']['fields'][] = array('transition_id' => 'Transition Id');
$structure['main']['fields'][] = array('transition_name' => 'Transition Name');
$structure['main']['fields'][] = array('transition_desc' => 'Description');
$structure['main']['fields'][] = array('transition_trigger' => 'Trigger');
$structure['main']['fields'][] = array('time_limit' => 'Time Limit');
$structure['main']['fields'][] = array('task_id' => 'Task');
$structure['main']['fields'][] = array('role_id' => 'Role');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>