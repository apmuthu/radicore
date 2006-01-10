<?php
$structure['xsl_file'] = 'std.multi3.xsl';

$structure['tables']['outer'] = 'mnu_task';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('task_desc' => 'Task');

$structure['tables']['middle'] = 'mnu_role';

$structure['middle']['columns'][] = array('width' => '25%');

$structure['middle']['fields'][] = array('role_desc' => 'Role');

$structure['tables']['inner'] = 'mnu_role_taskfield';

$structure['inner']['columns'][] = array('width' => 200);
$structure['inner']['columns'][] = array('width' => 100);
$structure['inner']['columns'][] = array('width' => '*');

$structure['inner']['fields'][] = array('field_id' => 'Field Id');
$structure['inner']['fields'][] = array('access_type' => 'Access');
$structure['inner']['fields'][] = array('blank' => '');

?>