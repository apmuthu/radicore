<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'product';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('product_name' => 'Product');

$structure['tables']['inner'] = 'prod_feature_applicability';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 75);
$structure['inner']['columns'][] = array('width' => 150);
$structure['inner']['columns'][] = array('width' => 75);
$structure['inner']['columns'][] = array('width' => 10);
$structure['inner']['columns'][] = array('width' => 95);
$structure['inner']['columns'][] = array('width' => 95);

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('prod_feature_cat_desc' => 'Category');
$structure['inner']['fields'][] = array('prod_feature_id' => 'Feature');
$structure['inner']['fields'][] = array('feature_type' => 'Type');
$structure['inner']['fields'][] = array('seq_no' => '#');
$structure['inner']['fields'][] = array('start_date' => 'Start Date');
$structure['inner']['fields'][] = array('end_date' => 'End Date');

?>