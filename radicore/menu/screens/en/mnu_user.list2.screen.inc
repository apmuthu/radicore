<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'mnu_role';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('role_desc' => 'Role');

$structure['tables']['inner'] = 'mnu_user';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 150);
$structure['inner']['columns'][] = array('width' => '*');

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('user_id' => 'User Id');
$structure['inner']['fields'][] = array('user_name' => 'User Name');

?>