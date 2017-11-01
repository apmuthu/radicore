<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'uom_conversion';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => "33%");
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => "33%");

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('uom_id_from' => 'FROM Unit');
$structure['main']['fields'][] = array('conversion_factor' => 'Factor');
$structure['main']['fields'][] = array('uom_id_to' => 'TO Unit');

?>