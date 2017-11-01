<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'facility';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '25%');

// identify the field names and their screen labels
$structure['outer']['fields'][] = array('facility_desc' => 'Facility');

$structure['tables']['inner'] = 'inventory_item';

// identify the column specs - may use 'width' or 'class'
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 25);
$structure['inner']['columns'][] = array('width' => 80);
$structure['inner']['columns'][] = array('width' => 30);
$structure['inner']['columns'][] = array('width' => 50);
$structure['inner']['columns'][] = array('width' => 80);

// identify the field names and their screen labels
$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('Product_id' => 'Product Id');
$structure['inner']['fields'][] = array('inventory_item_id' => 'Item Id');
$structure['inner']['fields'][] = array('serial_no' => 'Serial No.');
$structure['inner']['fields'][] = array('qty_on_hand' => 'Qty');
$structure['inner']['fields'][] = array('uom_abbrev' => 'UOM');
$structure['inner']['fields'][] = array('inv_item_status_id' => 'Status');

?>