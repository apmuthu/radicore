<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'container_type';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 25);
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('container_type_id' => 'Id');
$structure['main']['fields'][] = array('container_type_desc' => 'Description');

?>