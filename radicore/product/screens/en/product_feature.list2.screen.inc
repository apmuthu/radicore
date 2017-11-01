<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'product_feature_category';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '25%');

// identify the field names and their screen labels
$structure['outer']['fields'][] = array('prod_feature_cat_desc' => 'Feature Category');

$structure['tables']['inner'] = 'product_feature';

// identify the column specs - may use 'width' or 'class'
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('prod_feature_desc' => 'Description');

?>