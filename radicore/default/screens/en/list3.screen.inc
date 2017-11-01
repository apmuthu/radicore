<?php
$structure['xsl_file'] = 'std.list3.xsl';

$structure['tables']['outer'] = '#outer_table#';
$structure['tables']['middle'] = '#middle_table#';
$structure['tables']['inner'] = '#inner_table#';

// column widths for 'outer' table
$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '*');

// field names and labels for 'outer' table
$structure['outer']['fields'][] = array('fieldname' => 'Label');

// column widths for 'middle' table
$structure['middle']['columns'][] = array('width' => '25%');
$structure['middle']['columns'][] = array('width' => '*');

// field names and labels for 'middle' table
$structure['middle']['fields'][] = array('field1' => 'Label1');

// column widths for 'inner' table
$structure['inner']['columns'][] = array('width' => 5);

// field names and labels for 'inner' table
$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('fieldname' => 'Label');

?>