<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'inventory_item_status';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('inv_item_status_id' => 'Status Id');
$structure['main']['fields'][] = array('inv_item_status_desc' => 'Description');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>