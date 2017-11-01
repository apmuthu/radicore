<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'dict_database';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '75%');

$structure['main']['fields'][] = array('database_id' => 'Database Id');
$structure['main']['fields'][] = array('database_name' => 'Name');
$structure['main']['fields'][] = array('database_desc' => 'Description');
$structure['main']['fields'][] = array('subsys_id' => 'Subsystem');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>