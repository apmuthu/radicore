<?php
$structure['xsl_file'] = 'std.timetable1.xsl';

$structure['tables']['outer'] = 'crs_student';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('student_name' => 'Student');

$structure['tables']['inner'] = 'crs_schedule';

// no column values are required, will be generated automatically

$structure['inner']['fields'][] = array('start_time' => 'Time');
$structure['inner']['fields'][] = array('day_no1' => 'Monday');
$structure['inner']['fields'][] = array('day_no2' => 'Tuesday');
$structure['inner']['fields'][] = array('day_no3' => 'Wednesday');
$structure['inner']['fields'][] = array('day_no4' => 'Thursday');
$structure['inner']['fields'][] = array('day_no5' => 'Friday');

?>