<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'product_feature';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 125);
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('prod_feature_cat_id' => 'Category');
$structure['main']['fields'][] = array('prod_feature_desc' => 'Description');

?>