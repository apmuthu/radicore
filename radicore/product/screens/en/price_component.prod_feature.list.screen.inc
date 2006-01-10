<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'product_feature';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('prod_feature_desc' => 'Product Feature');

$structure['tables']['inner'] = 'price_component';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 100);
$structure['inner']['columns'][] = array('width' => 100);
$structure['inner']['columns'][] = array('width' => 50);
$structure['inner']['columns'][] = array('width' => 20);
$structure['inner']['columns'][] = array('width' => 100);
$structure['inner']['columns'][] = array('width' => 85);
$structure['inner']['columns'][] = array('width' => 85);

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('prod_cat_id' => 'Product Category');
$structure['inner']['fields'][] = array('product_id' => 'Product');
$structure['inner']['fields'][] = array('price_type' => 'Price Type');
$structure['inner']['fields'][] = array('price' => 'Price');
$structure['inner']['fields'][] = array('percent' => 'Percent');
$structure['inner']['fields'][] = array('price_frequency' => 'Frequency');
$structure['inner']['fields'][] = array('start_date' => 'Start Date');
$structure['inner']['fields'][] = array('end_date' => 'End Date');

?>