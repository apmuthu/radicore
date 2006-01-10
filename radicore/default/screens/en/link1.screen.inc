<?php
$structure['xsl_file'] = 'std.link1.xsl';

$structure['tables']['outer'] = '#outer_table#';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('fieldname' => 'Label');

$structure['tables']['link'] = '#link_table#';

// identify the column specs - may use 'width' or 'class'
// 'nosort' is optional (will prevent the label from being used as a hyperlink for sorting)
$structure['link']['columns'][] = array('width' => 5);
$structure['link']['columns'][] = array('width' => 100);
$structure['link']['columns'][] = array('width' => 250);
$structure['link']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['link']['fields'][] = array('selectbox' => 'Select');
$structure['link']['fields'][] = array('fieldname' => 'Label');
$structure['link']['fields'][] = array('fieldname' => 'Label', 'nosort' => 'y');

// the NOSORT keyword is optional, and will prevent the label from being a hyperlink
// which will allow the data to be sorted on that column

?>