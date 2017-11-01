<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'product';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('product_name' => 'Product Name');

$structure['tables']['inner'] = 'good_identification';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 200);
$structure['inner']['columns'][] = array('width' => 200);

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('identity_type_id' => 'Id Type');
$structure['inner']['fields'][] = array('id_value' => 'Id Value');

?>