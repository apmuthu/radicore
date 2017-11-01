<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'audit_logon_errors';

// identify the column specs - may use 'width' or 'class'
$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 150);
$structure['main']['columns'][] = array('width' => 150);
$structure['main']['columns'][] = array('width' => 150);
$structure['main']['columns'][] = array('width' => 150);
$structure['main']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('err_timestamp' => 'Date/Time');
$structure['main']['fields'][] = array('ip_address' => 'IP Address');
$structure['main']['fields'][] = array('user_id' => 'User Id');
$structure['main']['fields'][] = array('user_password' => 'Password');
$structure['main']['fields'][] = array('email_addr' => 'Email Address');

?>