<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_control';

$structure['main']['columns'][] = array('width' => '23%');
$structure['main']['columns'][] = array('width' => '11%');
$structure['main']['columns'][] = array('width' => '11%');
$structure['main']['columns'][] = array('width' => '11%');
$structure['main']['columns'][] = array('width' => '11%');
$structure['main']['columns'][] = array('width' => '11%');
$structure['main']['columns'][] = array('width' => '11%');
$structure['main']['columns'][] = array('width' => '11%');

$structure['main']['fields'][1] = array('default_language' => 'Default Language', 'colspan' => 7);
$structure['main']['fields'][2] = array('login_type' => 'Login Type', 'colspan' => 7);

$structure['main']['fields'][3][] = array('label' => 'Password Change', 'rowspan' => 2);
$structure['main']['fields'][3][] = array('field' => 'pswd_change', 'rowspan' => 2, 'colspan' => 3);
$structure['main']['fields'][3][] = array('label' => 'Password Count', 'colspan' => 2);
$structure['main']['fields'][3][] = array('field' => 'pswd_count', 'colspan' => 2);
$structure['main']['fields'][4][] = array('label' => 'Password Days', 'colspan' => 2);
$structure['main']['fields'][4][] = array('field' => 'pswd_days', 'colspan' => 2);

$structure['main']['fields'][5][] = array('label' => 'Password Retries');
$structure['main']['fields'][5][] = array('field' => 'pswd_retries', 'colspan' => 1);
$structure['main']['fields'][5][] = array('label' => 'Password Warning', 'colspan' => 2);
$structure['main']['fields'][5][] = array('field' => 'pswd_warning', 'colspan' => 4);

$structure['main']['fields'][6][] = array('label' => 'Format: Minimum length');
$structure['main']['fields'][6][] = array('field' => 'pswd_format_minlen', 'colspan' => 1);
$structure['main']['fields'][6][] = array('label' => 'Number of digits', 'colspan' => 2);
$structure['main']['fields'][6][] = array('field' => 'pswd_format_digits', 'colspan' => 4);

$structure['main']['fields'][8][] = array('label' => 'Format: Upper case chars');
$structure['main']['fields'][8][] = array('field' => 'pswd_format_upper', 'colspan' => 1);
$structure['main']['fields'][8][] = array('label' => 'Lower case chars', 'colspan' => 2);
$structure['main']['fields'][8][] = array('field' => 'pswd_format_lower', 'colspan' => 4);

$structure['main']['fields'][9][] = array('label' => 'Password Encryption?');
$structure['main']['fields'][9][] = array('field' => 'pswd_encrypt', 'colspan' => 3);
$structure['main']['fields'][9][] = array('label' => 'Hide Passwords?', 'colspan' => 2);
$structure['main']['fields'][9][] = array('field' => 'pswd_hidden', 'colspan' => 2);

$structure['main']['fields'][10][] = array('label' => 'Authentication?');
$structure['main']['fields'][10][] = array('field' => 'authentication', 'colspan' => 7);

$structure['main']['fields'][11][] = array('label' => 'Pagination Width');
$structure['main']['fields'][11][] = array('field' => 'pagination_width');
$structure['main']['fields'][11][] = array('label' => 'Scrolling Width', 'colspan' => 2);
$structure['main']['fields'][11][] = array('field' => 'scrolling_width', 'colspan' => 5);

$structure['main']['fields'][12][] = array('label' => 'Shutdown Start');
$structure['main']['fields'][12][] = array('field' => 'shutdown_start', 'colspan' => 1);
$structure['main']['fields'][12][] = array('label' => 'Shutdown End', 'colspan' => 2);
$structure['main']['fields'][12][] = array('field' => 'shutdown_end', 'colspan' => 1);
$structure['main']['fields'][12][] = array('label' => 'Shutdown Warning', 'colspan' => 2);
$structure['main']['fields'][12][] = array('field' => 'shutdown_warning', 'colspan' => 1);

$structure['main']['fields'][13][] = array('label' => 'Shutdown Days');
$structure['main']['fields'][13][] = array('field' => 'shutdown_monday');
$structure['main']['fields'][13][] = array('field' => 'shutdown_tuesday');
$structure['main']['fields'][13][] = array('field' => 'shutdown_wednesday');
$structure['main']['fields'][13][] = array('field' => 'shutdown_thursday');
$structure['main']['fields'][13][] = array('field' => 'shutdown_friday');
$structure['main']['fields'][13][] = array('field' => 'shutdown_saturday');
$structure['main']['fields'][13][] = array('field' => 'shutdown_sunday');

$structure['main']['fields'][14][] = array('label' => 'AUDIT entries age');
$structure['main']['fields'][14][] = array('field' => 'audit_delete');
$structure['main']['fields'][14][] = array('field' => 'audit_delete_period', 'colspan' => 6);

?>