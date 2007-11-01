<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_task';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => 300);

$structure['main']['fields'][] = array('task_id' => 'Old Task Id');
$structure['main']['fields'][] = array('task_desc' => 'Description');
$structure['main']['fields'][] = array('new_task_id' => 'New Task Id');

?>