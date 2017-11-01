<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'crs_lesson';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('lesson_name' => 'Lesson');

$structure['tables']['inner'] = 'crs_class_lesson';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 30);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 30);
$structure['inner']['columns'][] = array('width' => 30);

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('class_id' => 'Id');
$structure['inner']['fields'][] = array('class_name' => 'Class');
$structure['inner']['fields'][] = array('year' => 'Year');
$structure['inner']['fields'][] = array('student_count' => 'Students');

?>