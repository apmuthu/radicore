<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'test_autoincrement';

// identify the column specs - may use 'width' or 'class'
$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('id' => 'Id');
$structure['main']['fields'][] = array('field1' => 'Field1');
$structure['main']['fields'][] = array('field2' => 'Field2');
$structure['main']['fields'][] = array('bitwise' => 'Bitwise');

// the NOSORT keyword is optional, and will prevent the label from being a hyperlink
// which will allow the data to be sorted on that column

?>