<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'mnu_task';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '20%');
$structure['outer']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['outer']['fields'][] = array('task_id' => 'Task Id');
$structure['outer']['fields'][] = array('task_desc' => 'Task Description');

$structure['tables']['inner'] = 'mnu_task_quicksearch';

// identify the column specs - may use 'width' or 'class'
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 85, 'align' => 'center');
$structure['inner']['columns'][] = array('width' => 300);
$structure['inner']['columns'][] = array('width' => 300);
$structure['inner']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('sort_seq' => 'Sort Seq');
$structure['inner']['fields'][] = array('field_id' => 'Field Id');
$structure['inner']['fields'][] = array('field_name' => 'Field Name');
$structure['inner']['fields'][] = array('' => '');

?>