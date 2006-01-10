<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_task_field';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => 250);

$structure['main']['fields'][] = array('task_id' => 'Task');
$structure['main']['fields'][] = array('task_desc' => 'Description');
$structure['main']['fields'][] = array('field_id' => 'Field Id');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>