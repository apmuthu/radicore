<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'mnu_task';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
// identify the field names and their screen labels
$structure['outer']['fields'][] = array('task_id' => 'Task Id');
$structure['outer']['fields'][] = array('task_name' => 'Name');

$structure['tables']['inner'] = 'mnu_task_ip_address';

// identify the column specs - may use 'width' or 'class'
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 300);
$structure['inner']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('ip_address' => 'IP Address');
$structure['inner']['fields'][] = array('' => '');

?>