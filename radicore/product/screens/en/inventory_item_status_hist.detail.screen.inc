<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'inventory_item_status_hist';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('product_id' => 'Product Id');
$structure['main']['fields'][] = array('product_name' => 'Product Name');
$structure['main']['fields'][] = array('inventory_item_id' => 'Item Id');
$structure['main']['fields'][] = array('seq_no' => 'Seq No.');
$structure['main']['fields'][] = array('status_date' => 'Date');
$structure['main']['fields'][] = array('inv_item_status_id' => 'Status');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>