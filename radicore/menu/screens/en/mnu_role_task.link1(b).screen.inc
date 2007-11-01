<?php
$structure['xsl_file'] = 'std.link1.xsl';

$structure['tables']['outer'] = 'mnu_role';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('role_id' => 'Role Id');
$structure['outer']['fields'][] = array('role_desc' => 'Description');

$structure['tables']['link'] = 'mnu_role_task';

$structure['link']['columns'][] = array('width' => 5);
$structure['link']['columns'][] = array('width' => 250);
$structure['link']['columns'][] = array('width' => '*');

$structure['link']['fields'][] = array('selectbox' => 'Select');
$structure['link']['fields'][] = array('task_id' => 'Task Id');
$structure['link']['fields'][] = array('task_desc' => 'Description');

?>