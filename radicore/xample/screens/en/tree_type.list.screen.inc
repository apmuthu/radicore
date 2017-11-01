<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'x_tree_type';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 70);
$structure['main']['columns'][] = array('width' => 350);
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('tree_type_id' => 'Id');
$structure['main']['fields'][] = array('tree_type_desc' => 'Description');
$structure['main']['fields'][] = array('null' => '');

?>