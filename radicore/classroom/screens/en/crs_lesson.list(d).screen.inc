<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'crs_subject';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '25%');

// identify the field names and their screen labels
$structure['outer']['fields'][] = array('subject_name' => 'Subject');

$structure['tables']['inner'] = 'crs_lesson';

// identify the column specs - may use 'width' or 'class'
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 30);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => '*');

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('lesson_id' => 'Id');
$structure['inner']['fields'][] = array('lesson_name' => 'Lesson');
$structure['inner']['fields'][] = array('teacher_id' => 'Teacher');

?>