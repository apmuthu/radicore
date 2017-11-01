<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'product';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 100);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 40);
$structure['main']['columns'][] = array('width' => 10);

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('product_id' => 'Product Id');
$structure['main']['fields'][] = array('product_name' => 'Product Description');
$structure['main']['fields'][] = array('uom_abbrev' => 'UOM');
$structure['main']['fields'][] = array('product_subtype' => 'Subtype');

?>