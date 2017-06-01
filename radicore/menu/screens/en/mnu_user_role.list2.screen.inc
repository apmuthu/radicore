<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'mnu_user';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['outer']['fields'][] = array('user_id' => 'User Id');
$structure['outer']['fields'][] = array('user_name' => 'User Name');

$structure['tables']['inner'] = 'mnu_user_role';

// identify the column specs - may use 'width' or 'class'
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 125);
$structure['inner']['columns'][] = array('width' => 250);
$structure['inner']['columns'][] = array('width' => 100, 'align' => 'center');
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 100, 'align' => 'center');

// identify the field names and their screen labels
$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('role_id' => 'Role Id');
$structure['inner']['fields'][] = array('role_name' => 'Name');
$structure['inner']['fields'][] = array('is_primary' => 'Primary?');
$structure['inner']['fields'][] = array('start_task_name' => 'Start Task');
$structure['inner']['fields'][] = array('is_external_auth_off' => 'Ext Auth Off?');

?>