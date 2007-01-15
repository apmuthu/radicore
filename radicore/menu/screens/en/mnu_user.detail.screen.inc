<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_user';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '15%');
$structure['main']['columns'][] = array('width' => '35%');

$structure['main']['fields'][1] = array('user_id' => 'User Id', 'colspan' => 3);

$structure['main']['fields'][2] = array('user_name' => 'User Name', 'colspan' => 3);

$structure['main']['fields'][3] = array('user_password' => 'Password', 'colspan' => 3);

$structure['main']['fields'][4] = array('role_id' => 'Role', 'colspan' => 3);

$structure['main']['fields'][5][] = array('label' => 'Start Date');
$structure['main']['fields'][5][] = array('field' => 'start_date');
$structure['main']['fields'][5][] = array('label' => 'End Date');
$structure['main']['fields'][5][] = array('field' => 'end_date');

$structure['main']['fields'][6] = array('email_addr' => 'E-mail Address', 'colspan' => 3);

$structure['main']['fields'][7] = array('language_code' => 'Language Code', 'colspan' => 3);

$structure['main']['fields'][8] = array('in_use' => 'In Use', 'colspan' => 3);

$structure['main']['fields'][9] = array('is_disabled' => 'User Disabled', 'colspan' => 3);

$structure['main']['fields'][10] = array('ip_address' => 'IP Address', 'colspan' => 3);

$structure['main']['fields'][11][] = array('label' => 'Password Change Date');
$structure['main']['fields'][11][] = array('field' => 'pswd_chg_date');
$structure['main']['fields'][11][] = array('field' => 'pswd_chg_time', 'colspan' => 2);

$structure['main']['fields'][12] = array('pswd_count' => 'Password Count', 'colspan' => 3);

$structure['main']['fields'][13][] = array('label' => 'Logon Date');
$structure['main']['fields'][13][] = array('field' => 'logon_date');
$structure['main']['fields'][13][] = array('field' => 'logon_time', 'colspan' => 2);

$structure['main']['fields'][14] = array('created_date' => 'Created Date', 'colspan' => 3);

$structure['main']['fields'][15] = array('created_user' => 'Created By', 'colspan' => 3);

$structure['main']['fields'][16] = array('revised_date' => 'Revised Date', 'colspan' => 3);

$structure['main']['fields'][17] = array('revised_user' => 'Revised By', 'colspan' => 3);

?>