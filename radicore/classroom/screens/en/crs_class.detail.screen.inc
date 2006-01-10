<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'crs_class';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('class_id' => 'Id');
$structure['main']['fields'][] = array('class_name' => 'Name');
$structure['main']['fields'][] = array('year' => 'Year');
$structure['main']['fields'][] = array('student_count' => 'Student Count');
$structure['main']['fields'][] = array('class_notes' => 'Notes');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>