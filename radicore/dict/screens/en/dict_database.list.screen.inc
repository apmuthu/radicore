<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'dict_database';

$structure['main']['columns'][] = array('width' => 1);
$structure['main']['columns'][] = array('width' => 150);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 250);

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('database_id' => 'Database Id');
$structure['main']['fields'][] = array('database_desc' => 'Description');
$structure['main']['fields'][] = array('subsys_id' => 'Subsystem');

?>