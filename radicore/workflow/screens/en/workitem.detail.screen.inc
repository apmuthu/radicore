<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'wf_workitem';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('workflow_id' => 'Workflow');
$structure['main']['fields'][] = array('case_id' => 'Case Id');
$structure['main']['fields'][] = array('workitem_id' => 'Workitem Id');
$structure['main']['fields'][] = array('transition_id' => 'Transition Id');
$structure['main']['fields'][] = array('transition_trigger' => 'Transition Trigger');
$structure['main']['fields'][] = array('workitem_status' => 'Workitem Status');
$structure['main']['fields'][] = array('task_id' => 'Task Id');
$structure['main']['fields'][] = array('context' => 'Context');
$structure['main']['fields'][] = array('role_id' => 'Role Id');
$structure['main']['fields'][] = array('user_id' => 'User Id');
$structure['main']['fields'][] = array('enabled_date' => 'Enabled Date');
$structure['main']['fields'][] = array('cancelled_date' => 'Cancelled Date');
$structure['main']['fields'][] = array('finished_date' => 'Finished Date');
$structure['main']['fields'][] = array('deadline' => 'Deadline');

?>