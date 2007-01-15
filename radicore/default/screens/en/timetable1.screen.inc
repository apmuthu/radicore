<?php
$structure['xsl_file'] = 'std.timetable1.xsl';

$structure['tables']['outer'] = '#outer_table#';
$structure['tables']['inner'] = '#inner_table#';

$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['outer']['fields'][] = array('fieldname' => 'Label');

// no column values are required for 'inner', they will be generated automatically

// identify the field names and their screen labels
$structure['inner']['fields'][] = array('start_time' => 'Time');
$structure['inner']['fields'][] = array('day_no1' => 'Monday');
$structure['inner']['fields'][] = array('day_no2' => 'Tuesday');
$structure['inner']['fields'][] = array('day_no3' => 'Wednesday');
$structure['inner']['fields'][] = array('day_no4' => 'Thursday');
$structure['inner']['fields'][] = array('day_no5' => 'Friday');
//$structure['inner']['fields'][] = array('day_no6' => 'Saturday');
//$structure['inner']['fields'][] = array('day_no7' => 'Suniday');

?>