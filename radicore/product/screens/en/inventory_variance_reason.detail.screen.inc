<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'inventory_variance_reason';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('inv_var_reason_id' => 'Reason Id');
$structure['main']['fields'][] = array('inv_var_reason_desc' => 'Description');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>