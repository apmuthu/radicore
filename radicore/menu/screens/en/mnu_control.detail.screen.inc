<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_control';

$structure['main']['columns'][] = array('width' => '30%');
$structure['main']['columns'][] = array('width' => '70%');

$structure['main']['fields'][] = array('default_language' => 'Default Language');
$structure['main']['fields'][] = array('pswd_change' => 'Password Change');
$structure['main']['fields'][] = array('pswd_count' => 'Password Count');
$structure['main']['fields'][] = array('pswd_days' => 'Password Days');
$structure['main']['fields'][] = array('pswd_retries' => 'Password Retries');
$structure['main']['fields'][] = array('pswd_format_minlen' => 'Format: Minimum length');
$structure['main']['fields'][] = array('pswd_format_upper' => 'Format: Upper case chars');
$structure['main']['fields'][] = array('pswd_format_lower' => 'Format: Lower case chars');
$structure['main']['fields'][] = array('pswd_format_digits' => 'Format: Number of digits');
$structure['main']['fields'][] = array('pswd_encrypt' => 'Password Encryption?');

?>