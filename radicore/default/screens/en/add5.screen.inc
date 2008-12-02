<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = '#outer_table#';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['outer']['fields'][] = array('fieldname' => 'Label');
$structure['outer']['fields'][] = array('fieldname' => 'Label');

$structure['tables']['inner'] = '#inner_table#';

// identify the column specs - may use 'width' or 'class'
$structure['inner']['columns'][] = array('width' => '50%');
$structure['inner']['columns'][] = array('width' => '50%');

// identify the field names and their screen labels
//$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('fieldname' => 'Label');
$structure['inner']['fields'][] = array('fieldname' => 'Label');

?>
