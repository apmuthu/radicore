<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'mnu_user';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => 100);
$structure['outer']['columns'][] = array('width' => 100);
$structure['outer']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['outer']['fields'][1][] = array('label' => 'User Id');
$structure['outer']['fields'][1][] = array('field' => 'user_id');
$structure['outer']['fields'][1][] = array('label' => 'User Name');
$structure['outer']['fields'][1][] = array('field' => 'user_name');

$structure['tables']['inner'] = 'mnu_favourite';

// identify the column specs - may use 'width' or 'class'
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 25);
$structure['inner']['columns'][] = array('width' => 25);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('seq_no' => 'Id');
$structure['inner']['fields'][] = array('sort_seq' => 'Sort');
$structure['inner']['fields'][] = array('task_id' => 'Task Id');
$structure['inner']['fields'][] = array('task_name' => 'Task Name');

?>