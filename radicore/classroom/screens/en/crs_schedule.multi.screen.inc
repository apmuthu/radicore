<?php
$structure['xsl_file'] = 'std.multi3.xsl';

$structure['tables']['outer'] = 'crs_room';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('room_desc' => 'Room');

$structure['tables']['middle'] = 'crs_schedule_x01';

$structure['middle']['columns'][] = array('width' => '25%');

$structure['middle']['fields'][] = array('schedule_id' => 'Schedule Id');
$structure['middle']['fields'][] = array('schedule_desc' => 'Description');
$structure['middle']['fields'][] = array('day_no' => 'Day');

$structure['tables']['inner'] = 'crs_schedule';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 50);
$structure['inner']['columns'][] = array('width' => 50);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 25);

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('start_time' => 'Start');
$structure['inner']['fields'][] = array('end_time' => 'End');
$structure['inner']['fields'][] = array('lesson_id' => 'Lesson');
$structure['inner']['fields'][] = array('is_valid' => 'Valid?');

?>