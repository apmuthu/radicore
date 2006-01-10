<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'crs_teacher';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 30);
$structure['main']['columns'][] = array('width' => 100);
$structure['main']['columns'][] = array('width' => 300);
$structure['main']['columns'][] = array('width' => 300);

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('teacher_id' => 'Id');
$structure['main']['fields'][] = array('title' => 'Title');
$structure['main']['fields'][] = array('first_name' => 'First Name');
$structure['main']['fields'][] = array('last_name' => 'Last Name');

?>