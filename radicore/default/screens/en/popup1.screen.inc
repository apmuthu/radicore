<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = '#tablename#';

// identify the column specs - may use 'width' or 'class'
$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 100);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 10);
$structure['main']['columns'][] = array('width' => 10);
$structure['main']['columns'][] = array('width' => 10);

// identify the field names and their screen labels
$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('fieldname' => 'Label');
$structure['main']['fields'][] = array('fieldname' => 'Label', 'nosort' => 'y');

// the NOSORT keyword is optional, and will prevent the label from being a hyperlink
// which will allow the data to be sorted on that column

?>