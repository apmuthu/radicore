<?php
$structure['xsl_file'] = 'std.multi3.xsl';

$structure['tables']['outer'] = 'mnu_role';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['outer']['fields'][] = array('role_desc' => 'Role');

$structure['tables']['middle'] = 'mnu_task';

// identify the column specs - may use 'width' or 'class'
$structure['middle']['columns'][] = array('width' => '25%');
$structure['middle']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['middle']['fields'][] = array('task_desc' => 'Task');

$structure['tables']['inner'] = 'mnu_initial_value_role';

// identify the column specs - may use 'width' or 'class'
//$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 300);
$structure['inner']['columns'][] = array('width' => 350);
$structure['inner']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
//$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('field_id' => 'Field Id');
$structure['inner']['fields'][] = array('initial_value' => 'Initial Value');
$structure['inner']['fields'][] = array('' => '');

?>
