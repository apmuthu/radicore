<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'x_option';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 100);
$structure['main']['columns'][] = array('width' => 350);
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('option_id' => 'Id');
$structure['main']['fields'][] = array('option_desc' => 'Description');
$structure['main']['fields'][] = array('blank' => '');

?>