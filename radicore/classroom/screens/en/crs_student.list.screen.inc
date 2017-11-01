<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'crs_student';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 30);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 25);
$structure['main']['columns'][] = array('width' => 25);
$structure['main']['columns'][] = array('width' => 75);
$structure['main']['columns'][] = array('width' => 25);

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('student_id' => 'Id');
$structure['main']['fields'][] = array('last_name' => 'Last Name');
$structure['main']['fields'][] = array('first_name' => 'First Name');
$structure['main']['fields'][] = array('initials' => 'Initials');
$structure['main']['fields'][] = array('year' => 'Year');
$structure['main']['fields'][] = array('class_id' => 'Class');
$structure['main']['fields'][] = array('lesson_count' => 'Lessons');

?>