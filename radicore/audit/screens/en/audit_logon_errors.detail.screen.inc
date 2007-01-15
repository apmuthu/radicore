<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'audit_logon_errors';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '5%');
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][1][] = array('label' => 'Date From');
$structure['main']['fields'][1][] = array('field' => 'date_from');
$structure['main']['fields'][1][] = array('label' => 'To');
$structure['main']['fields'][1][] = array('field' => 'date_to');

$structure['main']['fields'][2] = array('ip_address' => 'IP Address', 'colspan' => 3);

$structure['main']['fields'][3] = array('user_id' => 'User Id', 'colspan' => 3);

$structure['main']['fields'][4] = array('user_password' => 'Password', 'colspan' => 3);

?>