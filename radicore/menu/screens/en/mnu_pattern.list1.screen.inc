<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'mnu_pattern';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 100);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 10, 'align' => 'right');

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('pattern_id' => 'ID');
$structure['main']['fields'][] = array('pattern_desc' => 'Description');
$structure['main']['fields'][] = array('task_count' => 'Tasks');

?>