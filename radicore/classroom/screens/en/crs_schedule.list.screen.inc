<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'crs_schedule_hdr';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('schedule_id' => 'Schedule Id');
$structure['outer']['fields'][] = array('schedule_desc' => 'Description');

$structure['tables']['inner'] = 'crs_schedule';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 125);
$structure['inner']['columns'][] = array('width' => 65);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 50);
$structure['inner']['columns'][] = array('width' => 50);
$structure['inner']['columns'][] = array('width' => 25);

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('seq_no' => 'Seq#');
$structure['inner']['fields'][] = array('room_id' => 'Room');
$structure['inner']['fields'][] = array('day_no' => 'Day');
$structure['inner']['fields'][] = array('lesson_id' => 'Lesson');
$structure['inner']['fields'][] = array('start_time' => 'Start');
$structure['inner']['fields'][] = array('end_time' => 'End');
$structure['inner']['fields'][] = array('is_valid' => 'Valid?');

?>