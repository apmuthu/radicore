<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'product_feature';

$structure['main']['columns'][] = array('width' => 205);
$structure['main']['columns'][] = array('width' => 185);
$structure['main']['columns'][] = array('width' => 150);
$structure['main']['columns'][] = array('width' => 210);

$structure['main']['fields'][1] = array('prod_feature_id' => 'Id', 'colspan' => 3);
$structure['main']['fields'][2] = array('prod_feature_cat_id' => 'Category', 'colspan' => 3);

$structure['main']['fields'][3][] = array('label' => 'Measurement Required?', 'rowspan' => 2);
$structure['main']['fields'][3][] = array('field' => 'measurement_reqd', 'rowspan' => 2);
$structure['main']['fields'][3][] = array('label' => 'Measurement');
$structure['main']['fields'][3][] = array('field' => 'measurement');
$structure['main']['fields'][] = array('uom_id' => 'Unit of Measure', 'display-empty' => 'y');

$structure['main']['fields'][] = array('prod_feature_desc' => 'Description', 'colspan' => 3);
$structure['main']['fields'][] = array('created_date' => 'Created Date', 'colspan' => 3);
$structure['main']['fields'][] = array('created_user' => 'Created By', 'colspan' => 3);
$structure['main']['fields'][] = array('revised_date' => 'Revised Date', 'colspan' => 3);
$structure['main']['fields'][] = array('revised_user' => 'Revised By', 'colspan' => 3);

?>