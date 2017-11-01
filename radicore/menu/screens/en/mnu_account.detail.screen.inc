<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_account';

// identify the column specs - may use 'width' or 'class'
$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '*');

// identify the contents of each row in the table (two formats are allowed)
// the SHORT format defines two cells per row, a label followed by a field, as in:
$structure['main']['fields'][] = array('rdcaccount_id' => 'Account Id');
$structure['main']['fields'][] = array('account_name' => 'Account Name');
$structure['main']['fields'][] = array('account_desc' => 'Description');
//$structure['main']['fields'][] = array('rdcversion' => 'Version Number');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created User');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised User');

?>