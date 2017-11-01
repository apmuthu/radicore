<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'crs_schedule_hdr';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('schedule_id' => 'Id');
$structure['main']['fields'][] = array('schedule_desc' => 'Description');
$structure['main']['fields'][] = array('schedule_notes' => 'Notes');
$structure['main']['fields'][] = array('is_active' => 'Active?');
$structure['main']['fields'][] = array('start_time' => 'Start Time');
$structure['main']['fields'][] = array('end_time' => 'End Time');
$structure['main']['fields'][] = array('last_day_no' => 'Last Day');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>