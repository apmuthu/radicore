<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'mnu_subsystem';

$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '*');

$structure['outer']['fields'][] = array('subsys_name' => 'Subsystem');

$structure['tables']['inner'] = 'mnu_task';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 50);

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('task_id' => 'Task');
$structure['inner']['fields'][] = array('task_name' => 'Name');
$structure['inner']['fields'][] = array('task_type' => 'Type');

?>