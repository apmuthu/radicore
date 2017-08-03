<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'mnu_task_jnr';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['outer']['fields'][] = array('task_id' => 'Child Task');
$structure['outer']['fields'][] = array('task_name' => 'Child Name');

$structure['tables']['inner'] = 'mnu_nav_button_snr';

// identify the column specs - may use 'width' or 'class'
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => '25%');
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 55);
$structure['inner']['columns'][] = array('width' => 120);
$structure['inner']['columns'][] = array('width' => 150);

// identify the field names and their screen labels
$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('task_id_snr' => 'Parent Task');
$structure['inner']['fields'][] = array('task_name_snr' => 'Parent Name');
$structure['inner']['fields'][] = array('sort_seq' => 'Seq');
$structure['inner']['fields'][] = array('context_preselect' => 'Preselect?');
$structure['inner']['fields'][] = array('button_text' => 'Button Text');

?>