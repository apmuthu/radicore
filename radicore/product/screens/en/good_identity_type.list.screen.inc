<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'good_identity_type';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 100);
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('identity_type_id' => 'Id');
$structure['main']['fields'][] = array('identity_type_desc' => 'Description');

?>