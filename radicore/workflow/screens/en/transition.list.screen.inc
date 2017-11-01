<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'wf_workflow';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('workflow_name' => 'Workflow Name');

$structure['tables']['inner'] = 'wf_transition';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 100);
$structure['inner']['columns'][] = array('width' => 200);
$structure['inner']['columns'][] = array('width' => 125);

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('transition_name' => 'Transition Name');
$structure['inner']['fields'][] = array('transition_trigger' => 'Trigger');
$structure['inner']['fields'][] = array('task_id' => 'Task');
$structure['inner']['fields'][] = array('role_id' => 'Role');

?>