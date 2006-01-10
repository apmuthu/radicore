<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'crs_room';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('room_id' => 'Id');
$structure['main']['fields'][] = array('room_desc' => 'Description');
$structure['main']['fields'][] = array('room_capacity' => 'Capacity');
$structure['main']['fields'][] = array('room_notes' => 'Notes');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>