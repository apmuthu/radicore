<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_task_field';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('task_id' => 'Task');
$structure['main']['fields'][] = array('task_name' => 'Task Name');
$structure['main']['fields'][] = array('field_id' => 'Field Id');
$structure['main']['fields'][] = array('field_desc' => 'Description');
$structure['main']['fields'][] = array('is_documentation_only' => 'Is Documentation Only?');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>