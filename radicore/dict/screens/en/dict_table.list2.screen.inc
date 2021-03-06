<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'dict_database';

$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '*');

$structure['outer']['fields'][] = array('database_id' => 'Database ID');

$structure['tables']['inner'] = 'dict_table';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 250);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 25, 'align' => 'center');
$structure['inner']['columns'][] = array('width' => 75, 'align' => 'center');
$structure['inner']['columns'][] = array('width' => 75, 'align' => 'center');

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('table_id' => 'Table Id');
$structure['inner']['fields'][] = array('table_name' => 'Name');
$structure['inner']['fields'][] = array('column_count' => 'Columns');
$structure['inner']['fields'][] = array('rel_count_snr' => 'Child Relationships');
$structure['inner']['fields'][] = array('rel_count_jnr' => 'Parent Relationships');

?>