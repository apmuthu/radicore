<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'product';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('product_name' => 'Product Name');

$structure['tables']['inner'] = 'prod_cat_class';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 200);
$structure['inner']['columns'][] = array('width' => 10);
$structure['inner']['columns'][] = array('width' => 10);
$structure['inner']['columns'][] = array('width' => 90);
$structure['inner']['columns'][] = array('width' => 90);

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('prod_cat_desc' => 'Category');
$structure['inner']['fields'][] = array('seq_no' => '#');
$structure['inner']['fields'][] = array('primary_flag' => 'Primary?');
$structure['inner']['fields'][] = array('start_date' => 'Start Date');
$structure['inner']['fields'][] = array('end_date' => 'End Date');

?>