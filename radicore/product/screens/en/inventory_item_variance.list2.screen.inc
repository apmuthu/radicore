<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'inventory_item';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '15%');
$structure['outer']['columns'][] = array('width' => '15%');
$structure['outer']['columns'][] = array('width' => '15%');
$structure['outer']['columns'][] = array('width' => '15%');
$structure['outer']['columns'][] = array('width' => '15%');

// identify the field names and their screen labels
$structure['outer']['fields'][] = array('product_name' => 'Product', 'colspan' => 5);
$structure['outer']['fields'][] = array('inventory_item_id' => 'Item Id', 'colspan' => 5);
$structure['outer']['fields'][3][] = array('label' => 'Qty on Hand');
$structure['outer']['fields'][3][] = array('field' => 'qty_on_hand');
$structure['outer']['fields'][3][] = array('label' => 'Variance');
$structure['outer']['fields'][3][] = array('field' => 'variance_qty');
$structure['outer']['fields'][3][] = array('label' => 'Total Qty');
$structure['outer']['fields'][3][] = array('field' => 'total_qty');

$structure['tables']['inner'] = 'inventory_item_variance';

// identify the column specs - may use 'width' or 'class'
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 30);
$structure['inner']['columns'][] = array('width' => 150);
$structure['inner']['columns'][] = array('width' => 150);
$structure['inner']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('seq_no' => 'Seq');
$structure['inner']['fields'][] = array('inventory_date' => 'Date');
$structure['inner']['fields'][] = array('variance_qty' => 'Quantity');
$structure['inner']['fields'][] = array('inv_var_reason_id' => 'Reason');

?>