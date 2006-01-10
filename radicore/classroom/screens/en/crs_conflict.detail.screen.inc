<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'crs_conflict';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('conflict_id' => 'Id');
$structure['main']['fields'][] = array('conflict_type' => 'Type');
$structure['main']['fields'][] = array('teacher_id' => 'Teacher');
$structure['main']['fields'][] = array('class_id' => 'Class');
$structure['main']['fields'][] = array('student_id' => 'Student');
$structure['main']['fields'][] = array('lesson_id1' => 'Lesson1');
$structure['main']['fields'][] = array('lesson_id2' => 'Lesson2');

?>