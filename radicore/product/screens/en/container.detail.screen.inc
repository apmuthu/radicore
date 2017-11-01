<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'container';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('facility_id' => 'Facility');
$structure['main']['fields'][] = array('container_id' => 'Container Id');
$structure['main']['fields'][] = array('container_type_id' => 'Container Type');
$structure['main']['fields'][] = array('container_desc' => 'Description');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>