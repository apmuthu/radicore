<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'audit_tbl';

$structure['outer']['columns'][] = array('width' => '8.4%');
$structure['outer']['columns'][] = array('width' => '16.7%');
$structure['outer']['columns'][] = array('width' => '8.4%');
$structure['outer']['columns'][] = array('width' => '16.7%');
$structure['outer']['columns'][] = array('width' => '8.4%');
$structure['outer']['columns'][] = array('width' => '16.7%');
$structure['outer']['columns'][] = array('width' => '8.4%');
$structure['outer']['columns'][] = array('width' => '*');

$structure['outer']['fields'][1][] = array('label' => 'User Id');
$structure['outer']['fields'][1][] = array('field' => 'user_id');
$structure['outer']['fields'][1][] = array('label' => 'Date');
$structure['outer']['fields'][1][] = array('field' => 'trn_datetime');
$structure['outer']['fields'][1][] = array('label' => 'Tran Seq');
$structure['outer']['fields'][1][] = array('field' => 'tran_seq_no');
$structure['outer']['fields'][1][] = array('label' => 'Table Seq');
$structure['outer']['fields'][1][] = array('field' => 'table_seq_no');

$structure['outer']['fields'][2][] = array('label' => 'Task');
$structure['outer']['fields'][2][] = array('field' => 'task_id');
$structure['outer']['fields'][2][] = array('label' => 'DBname');
$structure['outer']['fields'][2][] = array('field' => 'base_name');
$structure['outer']['fields'][2][] = array('label' => 'Table Name');
$structure['outer']['fields'][2][] = array('field' => 'table_name', 'colspan' => 3);

$structure['outer']['fields'][3][] = array('label' => 'Pkey');
$structure['outer']['fields'][3][] = array('field' => 'pkey', 'colspan' => 7);

$structure['tables']['inner'] = 'audit_fld';

$structure['inner']['columns'][] = array('width' => '33%');
$structure['inner']['columns'][] = array('width' => '33%');
$structure['inner']['columns'][] = array('width' => '33%');

$structure['inner']['fields'][] = array('field_id' => 'Field Id');
$structure['inner']['fields'][] = array('old_value' => 'Old value');
$structure['inner']['fields'][] = array('new_value' => 'New value');

?>