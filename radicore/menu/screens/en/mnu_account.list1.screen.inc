<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'mnu_account';

// identify the column specs - may use 'width' or 'class'
$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 25);
$structure['main']['columns'][] = array('width' => 500);
$structure['main']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('rdcaccount_id' => 'Id');
$structure['main']['fields'][] = array('account_name' => 'Account Name');
$structure['main']['fields'][] = array('' => '');

?>