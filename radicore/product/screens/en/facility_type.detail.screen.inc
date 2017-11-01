<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'facility_type';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('facility_type_id' => 'Facility Type Id');
$structure['main']['fields'][] = array('facility_type_desc' => 'Description');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>