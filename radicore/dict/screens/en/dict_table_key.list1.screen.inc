<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'dict_table_key';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 120);
$structure['main']['columns'][] = array('width' => 150);
$structure['main']['columns'][] = array('width' => 100);
$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 80);
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('database_id' => 'Database Id');
$structure['main']['fields'][] = array('table_id' => 'Table Id');
$structure['main']['fields'][] = array('key_name' => 'Key Name');
$structure['main']['fields'][] = array('seq_in_index' => 'Seq');
$structure['main']['fields'][] = array('is_unique' => 'Is Unique?');
$structure['main']['fields'][] = array('column_id' => 'Column Id');

?>