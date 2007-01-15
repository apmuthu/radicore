<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'inventory_variance_reason';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 25);
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('inv_var_reason_id' => 'Id');
$structure['main']['fields'][] = array('inv_var_reason_desc' => 'Description');

?>