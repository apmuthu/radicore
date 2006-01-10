<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_user';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('user_id' => 'User Id');
$structure['main']['fields'][] = array('user_name' => 'User Name');
$structure['main']['fields'][] = array('user_password' => 'Old Password');
$structure['main']['fields'][] = array('new_password1' => 'New Password');
$structure['main']['fields'][] = array('new_password2' => 'Repeat Password');

?>