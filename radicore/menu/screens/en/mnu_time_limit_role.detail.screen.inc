<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_time_limit_role';

// identify the column specs - may use 'width' or 'class'
$structure['main']['columns'][] = array('width' => '20%');
$structure['main']['columns'][] = array('width' => 90);
$structure['main']['columns'][] = array('width' => 90);
$structure['main']['columns'][] = array('width' => 90);
$structure['main']['columns'][] = array('width' => 90);
$structure['main']['columns'][] = array('width' => 90);
$structure['main']['columns'][] = array('width' => 90);
$structure['main']['columns'][] = array('width' => '*');

// identify the contents of each row in the table (two formats are allowed)
// the SHORT format defines two cells per row, a label followed by a field, as in:
$structure['main']['fields'][1][] = array('label' => 'Role Id');
$structure['main']['fields'][1][] = array('field' => 'role_id');
$structure['main']['fields'][1][] = array('field' => 'role_name', 'colspan' => 6);

$structure['main']['fields'][2] = array('seq_no' => 'Seq No', 'colspan' => 7);

$structure['main']['fields'][3][] = array('label' => 'Scheduled Start Time');
$structure['main']['fields'][3][] = array('field' => 'scheduled_start_time');
$structure['main']['fields'][3][] = array('label' => 'End Time');
$structure['main']['fields'][3][] = array('field' => 'scheduled_end_time', 'colspan' => 5);

$structure['main']['fields'][5][] = array('label' => 'Scheduled Days');
$structure['main']['fields'][5][] = array('field' => 'scheduled_monday');
$structure['main']['fields'][5][] = array('field' => 'scheduled_tuesday');
$structure['main']['fields'][5][] = array('field' => 'scheduled_wednesday');
$structure['main']['fields'][5][] = array('field' => 'scheduled_thursday');
$structure['main']['fields'][5][] = array('field' => 'scheduled_friday');
$structure['main']['fields'][5][] = array('field' => 'scheduled_saturday');
$structure['main']['fields'][5][] = array('field' => 'scheduled_sunday');

$structure['main']['fields'][] = array('created_date' => 'Created Date', 'colspan' => 7);
$structure['main']['fields'][] = array('created_user' => 'Created User', 'colspan' => 7);
$structure['main']['fields'][] = array('revised_date' => 'Revised Date', 'colspan' => 7);
$structure['main']['fields'][] = array('revised_user' => 'Revised User', 'colspan' => 7);

?>