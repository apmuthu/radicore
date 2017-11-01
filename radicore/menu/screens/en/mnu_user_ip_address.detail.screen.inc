<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_user_ip_address';

// identify the column specs - may use 'width' or 'class'
$structure['main']['columns'][] = array('width' => '20%');
$structure['main']['columns'][] = array('width' => '8.4%');
$structure['main']['columns'][] = array('width' => '8.4%');
$structure['main']['columns'][] = array('width' => '*');

// identify the contents of each row in the table (two formats are allowed)
// the SHORT format defines two cells per row, a label followed by a field, as in:
$structure['main']['fields'][1][] = array('label' => 'User Id');
$structure['main']['fields'][1][] = array('field' => 'user_id');
$structure['main']['fields'][1][] = array('label' => 'User Name');
$structure['main']['fields'][1][] = array('field' => 'user_name');

$structure['main']['fields'][] = array('ip_address' => 'IP Address', 'colspan' => 3);
$structure['main']['fields'][] = array('created_date' => 'Created Date', 'colspan' => 3);
$structure['main']['fields'][] = array('created_user' => 'Created User', 'colspan' => 3);
$structure['main']['fields'][] = array('revised_date' => 'Revised Date', 'colspan' => 3);
$structure['main']['fields'][] = array('revised_user' => 'Revised User', 'colspan' => 3);

?>