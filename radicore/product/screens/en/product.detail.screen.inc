<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'product';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('product_id' => 'Product Id');
$structure['main']['fields'][] = array('product_name' => 'Description');
$structure['main']['fields'][] = array('product_subtype' => 'Subtype');
$structure['main']['fields'][] = array('identity_type_id' => 'Id Type');
$structure['main']['fields'][] = array('id_value' => 'Id Value');
$structure['main']['fields'][] = array('prod_cat_id' => 'Product Category');
$structure['main']['fields'][] = array('prod_feature_id' => 'Product Feature');
$structure['main']['fields'][] = array('uom_id' => 'Measured in');
$structure['main']['fields'][] = array('date_intro' => 'Date Introduced');
$structure['main']['fields'][] = array('end_date_sales' => 'Sales End Date');
$structure['main']['fields'][] = array('end_date_support' => 'Support End Date');
$structure['main']['fields'][] = array('prod_comment' => 'Comment');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>