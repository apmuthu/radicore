<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'crs_teacher';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('teacher_name' => 'Teacher');

$structure['tables']['inner'] = 'crs_lesson';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 30);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 30);
$structure['inner']['columns'][] = array('width' => 30);
$structure['inner']['columns'][] = array('width' => 30);

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('lesson_id' => 'Id');
$structure['inner']['fields'][] = array('lesson_name' => 'Lesson');
$structure['inner']['fields'][] = array('year' => 'Year');
$structure['inner']['fields'][] = array('class_count' => 'Classes');
$structure['inner']['fields'][] = array('student_count' => 'Students');

?>