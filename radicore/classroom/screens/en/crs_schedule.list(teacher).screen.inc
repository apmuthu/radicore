<?php
$structure['xsl_file'] = 'std.timetable1.xsl';

$structure['tables']['outer'] = 'crs_teacher';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('teacher_name' => 'Teacher');

$structure['tables']['inner'] = 'crs_schedule';

$structure['inner']['columns'][] = array('width' => 25);
$structure['inner']['columns'][] = array('width' => '20%');
$structure['inner']['columns'][] = array('width' => '20%');
$structure['inner']['columns'][] = array('width' => '20%');
$structure['inner']['columns'][] = array('width' => '20%');
$structure['inner']['columns'][] = array('width' => '20%');

$structure['inner']['fields'][] = array('start_time' => 'Time');
$structure['inner']['fields'][] = array('day_no1' => 'Mon');
$structure['inner']['fields'][] = array('day_no2' => 'Tue');
$structure['inner']['fields'][] = array('day_no3' => 'Wed');
$structure['inner']['fields'][] = array('day_no4' => 'Thu');
$structure['inner']['fields'][] = array('day_no5' => 'Fri');

?>