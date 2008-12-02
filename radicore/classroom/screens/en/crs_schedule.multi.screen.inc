<?php
$structure['xsl_file'] = 'std.list3.xsl';

$structure['tables']['outer'] = 'crs_room';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('room_desc' => 'Room');

$structure['tables']['middle'] = 'crs_schedule_x01';

$structure['middle']['columns'][] = array('width' => '25%');
$structure['middle']['columns'][] = array('width' => 10);
$structure['middle']['columns'][] = array('width' => 1);
$structure['middle']['columns'][] = array('width' => '*');

$structure['middle']['fields'][1][] = array('label' => 'Schedule Id');
$structure['middle']['fields'][1][] = array('field' => 'schedule_id');
$structure['middle']['fields'][1][] = array('label' => '-');
$structure['middle']['fields'][1][] = array('field' => 'schedule_desc');
$structure['middle']['fields'][2][] = array('label' => 'Day');
$structure['middle']['fields'][2][] = array('field' => 'day_no');
$structure['middle']['fields'][2][] = array('label' => '-');
$structure['middle']['fields'][2][] = array('field' => 'day_name');

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