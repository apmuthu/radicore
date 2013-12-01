<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'mnu_role';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['outer']['fields'][] = array('role_id' => 'Role Id');
$structure['outer']['fields'][] = array('role_desc' => 'Role Description');

$structure['tables']['inner'] = 'mnu_time_limit_role';

// identify the column specs - may use 'width' or 'class'
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 50);
$structure['inner']['columns'][] = array('width' => 75);
$structure['inner']['columns'][] = array('width' => 75);
$structure['inner']['columns'][] = array('width' => 1, 'align' => 'center');
$structure['inner']['columns'][] = array('width' => 1, 'align' => 'center');
$structure['inner']['columns'][] = array('width' => 1, 'align' => 'center');
$structure['inner']['columns'][] = array('width' => 1, 'align' => 'center');
$structure['inner']['columns'][] = array('width' => 1, 'align' => 'center');
$structure['inner']['columns'][] = array('width' => 1, 'align' => 'center');
$structure['inner']['columns'][] = array('width' => 1, 'align' => 'center');
$structure['inner']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('seq_no' => 'Seq No');
$structure['inner']['fields'][] = array('scheduled_start_time' => 'Start Time');
$structure['inner']['fields'][] = array('scheduled_end_time' => 'End Time');
$structure['inner']['fields'][] = array('scheduled_monday' => 'Mon');
$structure['inner']['fields'][] = array('scheduled_tuesday' => 'Tue');
$structure['inner']['fields'][] = array('scheduled_wednesday' => 'Wed');
$structure['inner']['fields'][] = array('scheduled_thursday' => 'Thu');
$structure['inner']['fields'][] = array('scheduled_friday' => 'Fri');
$structure['inner']['fields'][] = array('scheduled_saturday' => 'Sat');
$structure['inner']['fields'][] = array('scheduled_sunday' => 'Sun');
$structure['inner']['fields'][] = array('' => '');

?>