<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'container';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 25);
$structure['main']['columns'][] = array('width' => 85);
$structure['main']['columns'][] = array('width' => 200);

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('facility_id' => 'Facility');
$structure['main']['fields'][] = array('container_id' => 'Id');
$structure['main']['fields'][] = array('container_type_id' => 'Container Type');
$structure['main']['fields'][] = array('container_desc' => 'Description');

?>