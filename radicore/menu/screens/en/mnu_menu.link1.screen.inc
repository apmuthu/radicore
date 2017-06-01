<?php
$structure['xsl_file'] = 'std.link1.xsl';

$structure['tables']['outer'] = 'mnu_task_snr';

$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '*');

$structure['outer']['fields'][] = array('task_id' => 'Menu Id');
$structure['outer']['fields'][] = array('task_name' => 'Menu Name');

$structure['tables']['link'] = 'mnu_menu';

$structure['link']['columns'][] = array('width' => 5);
$structure['link']['columns'][] = array('width' => 200);
$structure['link']['columns'][] = array('width' => '*');
$structure['link']['columns'][] = array('width' => 10);
$structure['link']['columns'][] = array('width' => 150);

$structure['link']['fields'][] = array('selectbox' => 'Select');
$structure['link']['fields'][] = array('task_id_jnr' => 'Task Id');
$structure['link']['fields'][] = array('task_name_jnr' => 'Task Name');
$structure['link']['fields'][] = array('sort_seq' => 'Seq');
$structure['link']['fields'][] = array('button_text' => 'Button Text', 'size' => 20);

?>