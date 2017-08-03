<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'mnu_task_snr';

$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '*');

$structure['outer']['fields'][] = array('task_id' => 'Task');
$structure['outer']['fields'][] = array('task_name' => 'Name');

$structure['tables']['inner'] = 'mnu_nav_button';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 55);
$structure['inner']['columns'][] = array('width' => 120);
$structure['inner']['columns'][] = array('width' => 150);

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('task_id_jnr' => 'Button Id');
$structure['inner']['fields'][] = array('task_name_jnr' => 'Name');
$structure['inner']['fields'][] = array('sort_seq' => 'Seq');
$structure['inner']['fields'][] = array('context_preselect' => 'Preselect?');
$structure['inner']['fields'][] = array('button_text' => 'Button Text', 'size' => 20);

?>