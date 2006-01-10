<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_subsystem';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '75%');

$structure['main']['fields'][] = array('subsys_id' => 'ID');
$structure['main']['fields'][] = array('subsys_desc' => 'Description');
$structure['main']['fields'][] = array('subsys_dir' => 'Directory');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>