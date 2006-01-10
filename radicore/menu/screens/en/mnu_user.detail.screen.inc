<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_user';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '85');
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][1] = array('user_id' => 'User Id', 'colspan' => 2);

$structure['main']['fields'][2] = array('user_name' => 'User Name', 'colspan' => 2);

$structure['main']['fields'][3] = array('user_password' => 'Password', 'colspan' => 2);

$structure['main']['fields'][4] = array('role_id' => 'Role', 'colspan' => 2);

$structure['main']['fields'][5][] = array('label' => 'Password Change Date');
$structure['main']['fields'][5][] = array('field' => 'pswd_chg_date');
$structure['main']['fields'][5][] = array('field' => 'pswd_chg_time');

$structure['main']['fields'][7] = array('pswd_count' => 'Password Count', 'colspan' => 2);

$structure['main']['fields'][8] = array('in_use' => 'In Use', 'colspan' => 2);

$structure['main']['fields'][9] = array('is_disabled' => 'User Disabled', 'colspan' => 2);

$structure['main']['fields'][10][] = array('label' => 'Logon Date');
$structure['main']['fields'][10][] = array('field' => 'logon_date');
$structure['main']['fields'][10][] = array('field' => 'logon_time');

$structure['main']['fields'][12] = array('language_code' => 'Language Code', 'colspan' => 2);

$structure['main']['fields'][13] = array('created_date' => 'Created Date', 'colspan' => 2);

$structure['main']['fields'][14] = array('created_user' => 'Created By', 'colspan' => 2);

$structure['main']['fields'][15] = array('revised_date' => 'Revised Date', 'colspan' => 2);

$structure['main']['fields'][16] = array('revised_user' => 'Revised By', 'colspan' => 2);

?>