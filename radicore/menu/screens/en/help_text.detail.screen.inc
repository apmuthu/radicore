<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'help_text';

$structure['main']['columns'][] = array('width' => '20%');
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('task_id' => 'Task');
$structure['main']['fields'][] = array('task_desc' => 'Description');
$structure['main']['fields'][] = array('help_text' => 'Text');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>