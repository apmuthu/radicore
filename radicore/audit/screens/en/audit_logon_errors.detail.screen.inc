<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'audit_logon_errors';

$structure['main']['columns'][] = array('width' => '20%');
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('id' => 'Id');
$structure['main']['fields'][] = array('user_id' => 'User Id');
$structure['main']['fields'][] = array('user_password' => 'Password');
$structure['main']['fields'][] = array('err_timestamp' => 'Timestamp');
$structure['main']['fields'][] = array('ip_address' => 'IP Address');
$structure['main']['fields'][] = array('email_addr' => 'Email Address');

?>