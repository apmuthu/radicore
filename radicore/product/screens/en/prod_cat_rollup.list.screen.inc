<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'product_category_snr';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('prod_cat_desc' => 'Description');

$structure['tables']['inner'] = 'prod_cat_rollup';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 75);
$structure['inner']['columns'][] = array('width' => '*');

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('prod_cat_id_jnr' => 'Id');
$structure['inner']['fields'][] = array('prod_cat_desc' => 'Description');

?>