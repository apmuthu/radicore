<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'unit_of_measure';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 100);
$structure['main']['columns'][] = array('width' => 100);
$structure['main']['columns'][] = array('width' => 50);
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('uom_cat_id' => 'Category');
$structure['main']['fields'][] = array('uom_id' => 'UOM Id');
$structure['main']['fields'][] = array('uom_abbrev' => 'Abbr.');
$structure['main']['fields'][] = array('uom_desc' => 'Description');

?>