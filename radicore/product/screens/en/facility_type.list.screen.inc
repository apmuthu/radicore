<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'facility_type';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 25);
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('facility_type_id' => 'Id');
$structure['main']['fields'][] = array('facility_type_desc' => 'Description');

?>