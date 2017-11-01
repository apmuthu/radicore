<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'inventory_item';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 25);
$structure['main']['columns'][] = array('width' => 30);
$structure['main']['columns'][] = array('width' => 50);
$structure['main']['columns'][] = array('width' => 80);

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('Product_id' => 'Product Id');
$structure['main']['fields'][] = array('inventory_item_id' => 'Item Id');
$structure['main']['fields'][] = array('qty_on_hand' => 'Qty');
$structure['main']['fields'][] = array('uom_abbrev' => 'UOM');
$structure['main']['fields'][] = array('inv_item_status_id' => 'Status');

?>