<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'facility';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 25);
$structure['main']['columns'][] = array('width' => 50);
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('facility_id' => 'Id');
$structure['main']['fields'][] = array('facility_type_id' => 'Type');
$structure['main']['fields'][] = array('facility_desc' => 'Description');

?>