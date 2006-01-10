<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'wf_case';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('workflow_name' => 'Workflow Name');
$structure['outer']['fields'][] = array('case_id' => 'Case Id');

$structure['tables']['inner'] = 'wf_workitem';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 100);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 75);
$structure['inner']['columns'][] = array('width' => 150);
$structure['inner']['columns'][] = array('width' => 150);

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('transition_trigger' => 'Transition Trigger');
$structure['inner']['fields'][] = array('task_id' => 'Task Id');
$structure['inner']['fields'][] = array('workitem_status' => 'Workitem Status');
$structure['inner']['fields'][] = array('enabled_date' => 'Enabled Date');
$structure['inner']['fields'][] = array('deadine' => 'Deadline');

?>