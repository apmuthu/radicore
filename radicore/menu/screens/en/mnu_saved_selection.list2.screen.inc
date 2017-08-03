<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'mnu_user';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['outer']['fields'][] = array('user_id' => 'User Id');
$structure['outer']['fields'][] = array('user_name' => 'User Name');

$structure['tables']['inner'] = 'mnu_saved_selection';

// identify the column specs - may use 'width' or 'class'
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 50);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 150);

// identify the field names and their screen labels
$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('selection_id' => 'Id');
$structure['inner']['fields'][] = array('selection_name' => 'Name');
$structure['inner']['fields'][] = array('task_name' => 'Task');
$structure['inner']['fields'][] = array('created_date' => 'Date');

?>