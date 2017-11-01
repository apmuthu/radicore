<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'mnu_user';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 150);
$structure['main']['columns'][] = array('width' => 250);
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('user_id' => 'User Id');
$structure['main']['fields'][] = array('user_name' => 'User Name');
$structure['main']['fields'][] = array('role_list' => 'Roles');

?>