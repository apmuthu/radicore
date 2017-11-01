<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'mnu_role';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 150);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 100, 'align' => 'center');
$structure['main']['columns'][] = array('width' => 25, 'align' => 'right');

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('role_id' => 'Role');
$structure['main']['fields'][] = array('role_name' => 'Name');
$structure['main']['fields'][] = array('start_task_id' => 'Start Task');
$structure['main']['fields'][] = array('global_access' => 'Global Access');
$structure['main']['fields'][] = array('count' => 'Users');

?>