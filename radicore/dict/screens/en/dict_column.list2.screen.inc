<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'dict_table';

$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '15%');
$structure['outer']['columns'][] = array('width' => '35%');

$structure['outer']['fields'][1][] = array('label' => 'Database Id');
$structure['outer']['fields'][1][] = array('field' => 'database_id');
$structure['outer']['fields'][1][] = array('label' => 'Table Id');
$structure['outer']['fields'][1][] = array('field' => 'table_id');

$structure['tables']['inner'] = 'dict_column';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 250);
$structure['inner']['columns'][] = array('width' => '*');

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('column_seq' => 'Seq');
$structure['inner']['fields'][] = array('column_id' => 'Column Id');
$structure['inner']['fields'][] = array('column_name' => 'Name');

?>