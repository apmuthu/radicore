<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'risk_weighting';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 20);
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('weighting_id' => 'Id');
$structure['main']['fields'][] = array('weighting_desc' => 'Description');

?>