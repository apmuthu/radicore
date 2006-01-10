<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'audit_tbl';

$structure['main']['columns'][] = array('width' => '175');
$structure['main']['columns'][] = array('width' => '125');
$structure['main']['columns'][] = array('width' => '10');
$structure['main']['columns'][] = array('width' => '500');

$structure['main']['fields'][1][] = array('label' => 'Date From');
$structure['main']['fields'][1][] = array('field' => 'date_from');
$structure['main']['fields'][1][] = array('label' => 'To');
$structure['main']['fields'][1][] = array('field' => 'date_to');

$structure['main']['fields'][2][] = array('label' => 'Time From');
$structure['main']['fields'][2][] = array('field' => 'time_from');
$structure['main']['fields'][2][] = array('label' => 'To');
$structure['main']['fields'][2][] = array('field' => 'time_to');

$structure['main']['fields'][3] = array('user_id' => 'User Id', 'colspan' => 3);

$structure['main']['fields'][4] = array('task_id' => 'Task Id', 'colspan' => 3);

$structure['main']['fields'][5] = array('base_name' => 'Database', 'colspan' => 3);

$structure['main']['fields'][7] = array('table_name' => 'Table', 'colspan' => 3);

$structure['main']['fields'][8] = array('pkey' => 'Primary Key', 'colspan' => 3);

?>