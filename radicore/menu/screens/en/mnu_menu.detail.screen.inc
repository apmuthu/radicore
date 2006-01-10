<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_menu';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '75%');

$structure['main']['fields'][] = array('menu_id' => 'Menu Id');
$structure['main']['fields'][] = array('task_desc_snr' => 'Description');
$structure['main']['fields'][] = array('task_id_jnr' => 'Task Id');
$structure['main']['fields'][] = array('task_desc_jnr' => 'Description');
$structure['main']['fields'][] = array('sort_seq' => 'Sort Sequence');
$structure['main']['fields'][] = array('button_text' => 'Button Text');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>