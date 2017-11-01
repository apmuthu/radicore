<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'price_component';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('prod_cat_id' => 'Product Category');
$structure['main']['fields'][] = array('prod_feature_id' => 'Product Feature');
$structure['main']['fields'][] = array('price_type' => 'Price Type');
$structure['main']['fields'][] = array('price' => 'Price');
$structure['main']['fields'][] = array('percent' => 'Percent');
$structure['main']['fields'][] = array('price_frequency' => 'Frequency');
$structure['main']['fields'][] = array('quantity' => 'Quantity');
$structure['main']['fields'][] = array('uom_id' => 'Unit of Measure');
$structure['main']['fields'][] = array('curr_or_hist' => 'Date Range');
$structure['main']['fields'][] = array('start_date' => 'Start Date');
$structure['main']['fields'][] = array('end_date' => 'End Date');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>