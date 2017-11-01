<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'crs_class';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('class_name' => 'Class');

$structure['tables']['inner'] = 'crs_class_lesson';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 30);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => '*');

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('lesson_id' => 'Id');
$structure['inner']['fields'][] = array('lesson_name' => 'Lesson');
$structure['inner']['fields'][] = array('teacher_id' => 'Teacher');

?>