<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'crs_lesson';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 25);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 25);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 25);
$structure['main']['columns'][] = array('width' => 25);

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('lesson_id' => 'Id');
$structure['main']['fields'][] = array('lesson_name' => 'Name');
$structure['main']['fields'][] = array('year' => 'Year');
$structure['main']['fields'][] = array('teacher_id' => 'Teacher');
$structure['main']['fields'][] = array('class_count' => 'Classes');
$structure['main']['fields'][] = array('student_count' => 'Students');

?>