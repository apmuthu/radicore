<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'prod_cat_class';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('product_name' => 'Product');
$structure['main']['fields'][] = array('prod_cat_id' => 'Category');
$structure['main']['fields'][] = array('seq_no' => 'Sequence No.');
$structure['main']['fields'][] = array('primary_flag' => 'Primary?');
$structure['main']['fields'][] = array('curr_or_hist' => 'Date Range');
$structure['main']['fields'][] = array('start_date' => 'Start Date');
$structure['main']['fields'][] = array('end_date' => 'End Date');
$structure['main']['fields'][] = array('pcc_comment' => 'Comment');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>