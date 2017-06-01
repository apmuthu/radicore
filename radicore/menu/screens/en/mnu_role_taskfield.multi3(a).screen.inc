<?php
$structure['xsl_file'] = 'std.list3.xsl';

$structure['tables']['outer'] = 'mnu_task';

$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '*');

$structure['outer']['fields'][] = array('task_name' => 'Task');

$structure['tables']['middle'] = 'mnu_role';

$structure['middle']['columns'][] = array('width' => '25%');
$structure['middle']['columns'][] = array('width' => '*');

$structure['middle']['fields'][] = array('role_name' => 'Role');

$structure['tables']['inner'] = 'mnu_role_taskfield';

$structure['inner']['columns'][] = array('width' => '25%');
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 100);

$structure['inner']['fields'][] = array('field_id' => 'Field Id');
$structure['inner']['fields'][] = array('field_desc' => 'Description');
$structure['inner']['fields'][] = array('access_type' => 'Access');

?>