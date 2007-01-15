<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'lot';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('lot_id' => 'Id');
$structure['main']['fields'][] = array('quantity' => 'Quantity');
$structure['main']['fields'][] = array('manuf_date' => 'Manufacture Date');
$structure['main']['fields'][] = array('expiry_date' => 'Expiry Date');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>