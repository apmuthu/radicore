<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'inventory_item';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '25%');

// identify the field names and their screen labels
$structure['outer']['fields'][] = array('product_name' => 'Product');
$structure['outer']['fields'][] = array('inventory_item_id' => 'Item Id');

$structure['tables']['inner'] = 'inventory_item_status_hist';

// identify the column specs - may use 'width' or 'class'
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 30);
$structure['inner']['columns'][] = array('width' => 150);
$structure['inner']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('seq_no' => 'Seq');
$structure['inner']['fields'][] = array('status_date' => 'Date');
$structure['inner']['fields'][] = array('inv_item_status_id' => 'Status');

?>