<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'crs_subject';

// identify the column specs - may use 'width' or 'class'
$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 100);
$structure['main']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('subject_id' => 'Id');
$structure['main']['fields'][] = array('subject_name' => 'Description');

?>