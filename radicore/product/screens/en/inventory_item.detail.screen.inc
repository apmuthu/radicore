<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'inventory_item';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '15%');
$structure['main']['columns'][] = array('width' => '15%');
$structure['main']['columns'][] = array('width' => '15%');
$structure['main']['columns'][] = array('width' => '15%');
$structure['main']['columns'][] = array('width' => '15%');

$structure['main']['fields'][1] = array('product_id' => 'Product Id', 'colspan' => 5);

$structure['main']['fields'][2][] = array('label' => 'Item Id');
$structure['main']['fields'][2][] = array('field' => 'inventory_item_id');
$structure['main']['fields'][2][] = array('field' => 'null');
$structure['main']['fields'][2][] = array('field' => 'null');
$structure['main']['fields'][2][] = array('field' => 'null');
$structure['main']['fields'][2][] = array('field' => 'null');

$structure['main']['fields'][3] = array('inv_type' => 'Type', 'colspan' => 5);
$structure['main']['fields'][4] = array('serial_no' => 'Serial No.', 'colspan' => 5);

//$structure['main']['fields'][] = array('total_qty' => 'Total Qty');
//$structure['main']['fields'][] = array('qty_on_hand' => 'Qty On Hand');
$structure['main']['fields'][5][] = array('label' => 'Qty on Hand');
$structure['main']['fields'][5][] = array('field' => 'qty_on_hand');
$structure['main']['fields'][5][] = array('label' => 'Variance');
$structure['main']['fields'][5][] = array('field' => 'variance_qty');
$structure['main']['fields'][5][] = array('label' => 'Total Qty');
$structure['main']['fields'][5][] = array('field' => 'total_qty');

$structure['main']['fields'][6] = array('inv_item_status_id' => 'Status', 'colspan' => 5);
$structure['main']['fields'][7] = array('facility_id' => 'Facility', 'colspan' => 5);
$structure['main']['fields'][8] = array('container_id' => 'Container Id', 'colspan' => 5);
$structure['main']['fields'][9] = array('lot_id' => 'Lot Id', 'colspan' => 5);

$structure['main']['fields'][] = array('created_date' => 'Created Date', 'colspan' => 5);
$structure['main']['fields'][] = array('created_user' => 'Created By', 'colspan' => 5);
$structure['main']['fields'][] = array('revised_date' => 'Revised Date', 'colspan' => 5);
$structure['main']['fields'][] = array('revised_user' => 'Revised By', 'colspan' => 5);

?>