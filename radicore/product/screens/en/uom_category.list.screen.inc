<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'uom_category';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 50);
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('uom_cat_id' => 'Id');
$structure['main']['fields'][] = array('uom_cat_desc' => 'Description');

?>