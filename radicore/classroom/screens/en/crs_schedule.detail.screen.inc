<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'crs_schedule';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('schedule_id' => 'Schedule Id');
$structure['main']['fields'][] = array('seq_no' => 'Seq #');
$structure['main']['fields'][] = array('room_id' => 'Room');
$structure['main']['fields'][] = array('room_capacity' => 'Room Capacity');
$structure['main']['fields'][] = array('day_no' => 'Day');
$structure['main']['fields'][] = array('lesson_id' => 'Lesson');
$structure['main']['fields'][] = array('teacher_name' => 'Teacher');
$structure['main']['fields'][] = array('student_count' => 'Student Count');
$structure['main']['fields'][] = array('start_time' => 'Start Time');
$structure['main']['fields'][] = array('end_time' => 'End Time');
$structure['main']['fields'][] = array('is_valid' => 'Valid?');
$structure['main']['fields'][] = array('schedule_errors' => 'Errors');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>