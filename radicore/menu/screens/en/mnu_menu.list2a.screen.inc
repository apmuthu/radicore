<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'mnu_task_jnr';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['outer']['fields'][] = array('task_id' => 'Task Id');
$structure['outer']['fields'][] = array('task_name' => 'Task Name');

$structure['tables']['inner'] = 'mnu_menu_snr';

// identify the column specs - may use 'width' or 'class'
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 200);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 50);
$structure['inner']['columns'][] = array('width' => 150);

// identify the field names and their screen labels
$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('menu_id' => 'Menu Id');
$structure['inner']['fields'][] = array('task_name_snr' => 'Menu Name');
$structure['inner']['fields'][] = array('sort_seq' => 'Sort Seq');
$structure['inner']['fields'][] = array('button_text' => 'Button Text');

?>