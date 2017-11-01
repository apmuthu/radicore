<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'product_feature_category';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('prod_feature_cat_id' => 'Category');
$structure['main']['fields'][] = array('prod_feature_cat_desc' => 'Description');
$structure['main']['fields'][] = array('measurement_reqd' => 'Measurement Required?');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>