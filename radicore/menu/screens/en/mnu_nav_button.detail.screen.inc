<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_nav_button';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '75%');

$structure['main']['fields'][] = array('task_id_snr' => 'Parent Task');
$structure['main']['fields'][] = array('task_name_snr' => 'Parent Name');
$structure['main']['fields'][] = array('task_id_jnr' => 'Button Id');
$structure['main']['fields'][] = array('task_name_jnr' => 'Task Name');
$structure['main']['fields'][] = array('sort_seq' => 'Sort Sequence');
$structure['main']['fields'][] = array('button_text' => 'Button Text');
$structure['main']['fields'][] = array('context_preselect' => 'Preselect?');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>