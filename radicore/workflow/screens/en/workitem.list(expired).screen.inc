<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'wf_workitem';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 35);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 150);
$structure['main']['columns'][] = array('width' => 150);
$structure['main']['columns'][] = array('width' => 250);

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('case_id' => 'Case');
$structure['main']['fields'][] = array('workflow_name' => 'Workflow Name');
$structure['main']['fields'][] = array('enabled_date' => 'Enabled Date');
$structure['main']['fields'][] = array('deadline' => 'Deadline');
$structure['main']['fields'][] = array('task_id' => 'Task');

?>