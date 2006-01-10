<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'crs_lesson';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('lesson_name' => 'Lesson');

$structure['tables']['inner'] = 'crs_student_lesson';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 30);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 10);

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('student_id' => 'Id');
$structure['inner']['fields'][] = array('last_name' => 'Last Name');
$structure['inner']['fields'][] = array('first_name' => 'First Name');
$structure['inner']['fields'][] = array('initials' => 'Initials');

?>