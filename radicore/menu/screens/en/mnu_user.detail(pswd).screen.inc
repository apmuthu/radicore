<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_user';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '150');
$structure['main']['columns'][] = array('width' => '150');
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][1] = array('user_id' => 'User Id', 'colspan' => 3);
$structure['main']['fields'][2] = array('user_name' => 'User Name', 'colspan' => 3);
$structure['main']['fields'][3] = array('old_password' => 'Old Password', 'colspan' => 3);

$structure['main']['fields'][4][] = array('label' => 'New Password');
$structure['main']['fields'][4][] = array('field' => 'new_password1');
$structure['main']['fields'][4][] = array('field' => 'password_description');
$structure['main']['fields'][4][] = array('field' => 'password_strength');

//$structure['main']['fields'][5] = array('new_password2' => 'Repeat Password', 'colspan' => 3);
$structure['main']['fields'][5][] = array('label' => 'Repeat Password');
$structure['main']['fields'][5][] = array('field' => 'new_password2');
$structure['main']['fields'][5][] = array('' => '');
$structure['main']['fields'][5][] = array('' => '');

?>
