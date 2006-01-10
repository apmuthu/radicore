<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'crs_schedule_hdr';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 10);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 10);

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('schedule_id' => 'Id');
$structure['main']['fields'][] = array('schedule_desc' => 'Description');
$structure['main']['fields'][] = array('is_active' => 'Active?');

?>