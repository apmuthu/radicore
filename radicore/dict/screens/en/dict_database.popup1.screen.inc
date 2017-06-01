<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'dict_database';

// identify the column specs - may use 'width' or 'class'
$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 100);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 300);

// identify the field names and their screen labels
$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('database_id' => 'Database Id');
$structure['main']['fields'][] = array('database_name' => 'Database Name');
$structure['main']['fields'][] = array('subsys_id' => 'Subsys Id');

?>