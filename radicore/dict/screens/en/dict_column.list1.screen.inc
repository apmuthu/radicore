<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'dict_column';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 125);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 10, 'align' => 'center');
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('database_id' => 'Database Id');
$structure['main']['fields'][] = array('table_id' => 'Table Id');
$structure['main']['fields'][] = array('column_seq' => 'Seq');
$structure['main']['fields'][] = array('column_id' => 'Column Id');
$structure['main']['fields'][] = array('column_desc' => 'Description');

?>