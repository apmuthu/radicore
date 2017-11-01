<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'crs_student';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('student_name' => 'Student');

$structure['tables']['inner'] = 'crs_student_lesson';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 30);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => '*');

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('lesson_id' => 'Id');
$structure['inner']['fields'][] = array('lesson_name' => 'Lesson');
$structure['inner']['fields'][] = array('teacher_id' => 'Teacher');

?>