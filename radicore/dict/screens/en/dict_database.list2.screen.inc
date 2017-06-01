<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'mnu_subsystem';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('subsys_name' => 'Subsystem');

$structure['tables']['inner'] = 'dict_database';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 150);
$structure['inner']['columns'][] = array('width' => '*');

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('database_id' => 'Database Id');
$structure['inner']['fields'][] = array('database_name' => 'Name');

?>