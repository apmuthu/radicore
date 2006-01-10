<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'product';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('product_name' => 'Product');

$structure['tables']['inner'] = 'prod_feature_interaction';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 100);
$structure['inner']['columns'][] = array('width' => 100);
$structure['inner']['columns'][] = array('width' => 100);

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('prod_feature_id_snr' => 'Feature 1');
$structure['inner']['fields'][] = array('prod_feature_id_jnr' => 'Feature 2');
$structure['inner']['fields'][] = array('feature_interaction' => 'Interaction');

?>