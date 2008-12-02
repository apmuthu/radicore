<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'crs_class';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 100);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 10);
$structure['main']['columns'][] = array('width' => 10);
$structure['main']['columns'][] = array('width' => 10);

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('class_id' => 'Id');
$structure['main']['fields'][] = array('class_name' => 'Name');
$structure['main']['fields'][] = array('year' => 'Year');
$structure['main']['fields'][] = array('lesson_count' => 'Lessons');
$structure['main']['fields'][] = array('student_count' => 'Students');

?>