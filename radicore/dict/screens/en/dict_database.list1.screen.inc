<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'dict_database';

$structure['main']['columns'][] = array('width' => 1);
$structure['main']['columns'][] = array('width' => 115);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 50, 'align' => 'center');
$structure['main']['columns'][] = array('width' => 75, 'align' => 'center');
$structure['main']['columns'][] = array('width' => 75, 'align' => 'center');

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('database_id' => 'Database Id');
$structure['main']['fields'][] = array('database_name' => 'Name');
$structure['main']['fields'][] = array('subsys_name' => 'Subsystem');
$structure['main']['fields'][] = array('table_count' => 'Tables');
$structure['main']['fields'][] = array('rel_count_snr' => 'Child Relationships');
$structure['main']['fields'][] = array('rel_count_jnr' => 'Parent Relationships');

?>