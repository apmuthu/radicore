<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'crs_conflict';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 10);
$structure['main']['columns'][] = array('width' => 10);
$structure['main']['columns'][] = array('width' => 10);
$structure['main']['columns'][] = array('width' => 10);
$structure['main']['columns'][] = array('width' => 10);

$structure['main']['fields'][] = array('conflict_id' => 'Id');
$structure['main']['fields'][] = array('class_id' => 'Class');
$structure['main']['fields'][] = array('student_name' => 'Student');
$structure['main']['fields'][] = array('teacher_name' => 'Teacher');
$structure['main']['fields'][] = array('lesson_name1' => 'Lesson1');
$structure['main']['fields'][] = array('lesson_name2' => 'Lesson2');

?>