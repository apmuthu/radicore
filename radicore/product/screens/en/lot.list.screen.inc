<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'lot';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 100);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 100);
$structure['main']['columns'][] = array('width' => 100);

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('lot_id' => 'Id');
$structure['main']['fields'][] = array('quantity' => 'Quantity');
$structure['main']['fields'][] = array('manuf_date' => 'Manufacture Date');
$structure['main']['fields'][] = array('expiry_date' => 'Expiry Date');

?>