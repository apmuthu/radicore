<?php
$structure['xsl_file'] = 'std.link1.xsl';

$structure['tables']['outer'] = 'mnu_task_snr';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('task_id' => 'Task');
$structure['outer']['fields'][] = array('task_desc' => 'Description');

$structure['tables']['link'] = 'mnu_nav_button';

$structure['link']['columns'][] = array('width' => 5);
$structure['link']['columns'][] = array('width' => '25%');
$structure['link']['columns'][] = array('width' => '*');
$structure['link']['columns'][] = array('width' => 25);
$structure['link']['columns'][] = array('width' => 100);
$structure['link']['columns'][] = array('width' => 150);

$structure['link']['fields'][] = array('selectbox' => 'Select');
$structure['link']['fields'][] = array('task_id_jnr' => 'Button Id');
$structure['link']['fields'][] = array('task_desc_jnr' => 'Description');
$structure['link']['fields'][] = array('sort_seq' => 'Seq');
$structure['link']['fields'][] = array('context_preselect' => 'Preselect?');
$structure['link']['fields'][] = array('button_text' => 'Button Text', 'size' => 20);

?>