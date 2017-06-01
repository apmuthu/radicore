<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'mnu_task';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 50);

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('task_id' => 'Task');
$structure['main']['fields'][] = array('task_name' => 'Name');
$structure['main']['fields'][] = array('task_type' => 'Type');

?>