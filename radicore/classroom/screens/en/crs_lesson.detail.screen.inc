<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'crs_lesson';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('lesson_id' => 'Id');
$structure['main']['fields'][] = array('lesson_name' => 'Name');
$structure['main']['fields'][] = array('lesson_short_name' => 'Short Name');
$structure['main']['fields'][] = array('subject_id' => 'Subject');
$structure['main']['fields'][] = array('year' => 'Year');
$structure['main']['fields'][] = array('teacher_id' => 'Teacher');
$structure['main']['fields'][] = array('student_count' => 'Student Count');
$structure['main']['fields'][] = array('lesson_notes' => 'Notes');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>