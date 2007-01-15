<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'mnu_task_snr';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('task_id' => 'Menu Id');
$structure['outer']['fields'][] = array('task_desc' => 'Description');

$structure['tables']['inner'] = 'mnu_menu';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 200);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 10);
$structure['inner']['columns'][] = array('width' => 100);

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('task_id_jnr' => 'Task Id');
$structure['inner']['fields'][] = array('task_desc_jnr' => 'Description');
$structure['inner']['fields'][] = array('sort_seq' => 'Seq');
$structure['inner']['fields'][] = array('button_text' => 'Button Text');

?>