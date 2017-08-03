<?php
$structure['xsl_file'] = 'std.list3.xsl';

$structure['tables']['outer'] = 'audit_tbl_key';

$structure['outer']['columns'][] = array('width' => '100');
$structure['outer']['columns'][] = array('width' => '*');

$structure['outer']['fields'][] = array('audit_dtl_key' => 'Key');

$structure['tables']['middle'] = 'audit_tbl';

$structure['middle']['columns'][] = array('width' => '8.4%');
$structure['middle']['columns'][] = array('width' => '16.7%');
$structure['middle']['columns'][] = array('width' => '8.4%');
$structure['middle']['columns'][] = array('width' => '16.7%');
$structure['middle']['columns'][] = array('width' => '8.4%');
$structure['middle']['columns'][] = array('width' => '16.7%');
$structure['middle']['columns'][] = array('width' => '8.4%');
$structure['middle']['columns'][] = array('width' => '*');

$structure['middle']['fields'][1][] = array('label' => 'User Id');
$structure['middle']['fields'][1][] = array('field' => 'user_id');
$structure['middle']['fields'][1][] = array('label' => 'Date');
$structure['middle']['fields'][1][] = array('field' => 'trn_datetime');
$structure['middle']['fields'][1][] = array('label' => 'Tran Seq');
$structure['middle']['fields'][1][] = array('field' => 'tran_seq_no');
$structure['middle']['fields'][1][] = array('label' => 'Table Seq');
$structure['middle']['fields'][1][] = array('field' => 'table_seq_no');

$structure['middle']['fields'][2][] = array('label' => 'Task');
$structure['middle']['fields'][2][] = array('field' => 'task_id');
$structure['middle']['fields'][2][] = array('label' => 'DBname');
$structure['middle']['fields'][2][] = array('field' => 'base_name');
$structure['middle']['fields'][2][] = array('label' => 'Table Name');
$structure['middle']['fields'][2][] = array('field' => 'table_name', 'colspan' => 3);

$structure['middle']['fields'][3][] = array('label' => 'Pkey');
$structure['middle']['fields'][3][] = array('field' => 'pkey', 'colspan' => 7);

$structure['tables']['inner'] = 'audit_fld';

$structure['inner']['columns'][] = array('width' => '33%');
$structure['inner']['columns'][] = array('width' => '33%');
$structure['inner']['columns'][] = array('width' => '33%');

$structure['inner']['fields'][] = array('field_id' => 'Field Id');
$structure['inner']['fields'][] = array('old_value' => 'Old value');
$structure['inner']['fields'][] = array('new_value' => 'New value');

?>