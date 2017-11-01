<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'mnu_task';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '20%');
$structure['outer']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['outer']['fields'][] = array('task_id' => 'Task Id');
$structure['outer']['fields'][] = array('task_name' => 'Task Name');
$structure['outer']['fields'][] = array('button_text' => 'Button Text');

$structure['tables']['inner'] = 'mnu_task_alt';

// identify the column specs - may use 'width' or 'class'
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 200);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 250);

// identify the field names and their screen labels
$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('language_id' => 'Language Id');
$structure['inner']['fields'][] = array('task_name' => 'Task Name');
$structure['inner']['fields'][] = array('button_text' => 'Button Text');

?>