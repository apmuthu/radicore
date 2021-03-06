<?php
$structure['xsl_file'] = 'std.list3.xsl';

$structure['tables']['outer'] = 'mnu_task';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => 100);
$structure['outer']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['outer']['fields'][1][] = array('label' => 'Task Id');
$structure['outer']['fields'][1][] = array('field' => 'task_id');
$structure['outer']['fields'][1][] = array('label' => 'Name');
$structure['outer']['fields'][1][] = array('field' => 'task_name');

$structure['tables']['middle'] = 'mnu_role';

// identify the column specs - may use 'width' or 'class'
$structure['middle']['columns'][] = array('width' => '25%');
$structure['middle']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['middle']['fields'][] = array('role_name' => 'Role');

$structure['tables']['inner'] = 'mnu_initial_value_role';

// identify the column specs - may use 'width' or 'class'
//$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => '20%');
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 200);
$structure['inner']['columns'][] = array('width' => 60);

// identify the field names and their screen labels
//$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('field_id' => 'Field Id');
$structure['inner']['fields'][] = array('field_desc' => 'Description');
$structure['inner']['fields'][] = array('initial_value' => 'Initial Value', 'size' => 40);
$structure['inner']['fields'][] = array('is_noedit' => 'No Edit?');

?>
