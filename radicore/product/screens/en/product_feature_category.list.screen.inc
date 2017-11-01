<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'product_feature_category';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 20);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 20);

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('prod_feature_cat_id' => 'Category');
$structure['main']['fields'][] = array('prod_feature_cat_desc' => 'Description');
$structure['main']['fields'][] = array('measurement_reqd' => 'Measurement Required?');

?>