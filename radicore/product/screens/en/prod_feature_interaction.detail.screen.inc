<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'prod_feature_interaction';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('product_name' => 'Product');
$structure['main']['fields'][] = array('prod_feature_id_snr' => 'Feature 1');
$structure['main']['fields'][] = array('prod_feature_id_jnr' => 'Feature 2');
$structure['main']['fields'][] = array('feature_interaction' => 'Interaction');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>