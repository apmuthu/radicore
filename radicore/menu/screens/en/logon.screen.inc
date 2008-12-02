<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'logon';

$structure['main']['columns'][] = array('width' => '30%');
$structure['main']['columns'][] = array('width' => '70%');

$structure['main']['fields'][] = array('user_id' => 'User Id');
$structure['main']['fields'][] = array('email_addr' => 'Email', 'size' => 40);
$structure['main']['fields'][] = array('user_password' => 'Password', 'size' => 16);

?>