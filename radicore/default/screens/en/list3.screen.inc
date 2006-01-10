<?php
$structure['xsl_file'] = 'std.list3.xsl';

$structure['tables']['outer'] = '#outer_table#';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('fieldname' => 'Label');

$structure['tables']['middle'] = '#middle_table#';

// identify the column specs - may use 'width' or 'class'
$structure['middle']['columns'][] = array('width' => '100');
$structure['middle']['columns'][] = array('width' => '150');

// identify the field names and their screen labels
$structure['middle']['fields'][] = array('field1' => 'Label1');
$structure['middle']['fields'][] = array('field2' => 'Label2');
$structure['middle']['fields'][] = array('field3' => 'Label3');

$structure['tables']['inner'] = '#inner_table#';

// identify the column specs - may use 'width' or 'class'
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 30);
$structure['inner']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('fieldname' => 'Label');
$structure['inner']['fields'][] = array('fieldname' => 'Label', 'nosort' => 'y');

// the NOSORT keyword is optional, and will prevent the label from being a hyperlink
// which will allow the data to be sorted on that column

?>