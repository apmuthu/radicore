<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'good_identification';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('product_id' => 'Product Id');
$structure['main']['fields'][] = array('product_name' => 'Product Name');
$structure['main']['fields'][] = array('identity_type_id' => 'Identity Type');
$structure['main']['fields'][] = array('id_value' => 'Identity Value');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>