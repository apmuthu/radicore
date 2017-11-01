<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'prod_feature_applicability';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('product_name' => 'Product');
$structure['main']['fields'][] = array('prod_feature_cat_desc' => 'Category');
$structure['main']['fields'][] = array('prod_feature_id' => 'Feature');
$structure['main']['fields'][] = array('seq_no' => 'Seq No.');
$structure['main']['fields'][] = array('feature_type' => 'Feature Type');
$structure['main']['fields'][] = array('curr_or_hist' => 'Date Range');
$structure['main']['fields'][] = array('start_date' => 'Start Date');
$structure['main']['fields'][] = array('end_date' => 'End Date');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>