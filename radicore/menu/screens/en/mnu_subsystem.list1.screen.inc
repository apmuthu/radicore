<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'mnu_subsystem';

$structure['main']['columns'][] = array('width' => 1);
$structure['main']['columns'][] = array('width' => 100);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 100);
$structure['main']['columns'][] = array('width' => 75);
$structure['main']['columns'][] = array('width' => 10, 'align' => 'right');

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('subsys_id' => 'ID');
$structure['main']['fields'][] = array('subsys_name' => 'Name');
$structure['main']['fields'][] = array('subsys_dir' => 'Directory');
$structure['main']['fields'][] = array('task_prefix' => 'Task Prefix');
$structure['main']['fields'][] = array('task_count' => 'Tasks');

?>