<?php
$structure['xsl_file'] = 'std.multi3.xsl';

$structure['tables']['outer'] = 'mnu_role';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('role_desc' => 'Role');

$structure['tables']['middle'] = 'mnu_task';

$structure['middle']['columns'][] = array('width' => '25%');

$structure['middle']['fields'][] = array('task_desc' => 'Task');

$structure['tables']['inner'] = 'mnu_role_taskfield';

$structure['inner']['columns'][] = array('width' => 300);
$structure['inner']['columns'][] = array('width' => 100);
$structure['inner']['columns'][] = array('width' => '*');

$structure['inner']['fields'][] = array('field_id' => 'Field Id');
$structure['inner']['fields'][] = array('access_type' => 'Access');
$structure['inner']['fields'][] = array('blank' => '');

?>