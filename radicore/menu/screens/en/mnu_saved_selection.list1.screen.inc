<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'mnu_saved_selection';

// identify the column specs - may use 'width' or 'class'
$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 75);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 150);

// identify the field names and their screen labels
$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('selection_id' => 'Selection Id');
$structure['main']['fields'][] = array('selection_name' => 'Selection Name');
$structure['main']['fields'][] = array('user_name' => 'User Name');
$structure['main']['fields'][] = array('task_name' => 'Task Name');
$structure['main']['fields'][] = array('created_date' => 'Created Date');

?>