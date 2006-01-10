<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'logon';

$structure['main']['columns'][] = array('width' => '40%');
$structure['main']['columns'][] = array('width' => '60%');

$structure['main']['fields'][] = array('user_id' => 'User Id');
$structure['main']['fields'][] = array('user_password' => 'Password');

?>