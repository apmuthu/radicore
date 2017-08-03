<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'output4_header';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '8.4%');
$structure['outer']['columns'][] = array('width' => '8.4%');
$structure['outer']['columns'][] = array('width' => '*');

$structure['outer']['fields'][0][] = array('label' => 'Restore Selection');
$structure['outer']['fields'][0][] = array('field' => 'rdc_restore_selection', 'colspan' => 3);

$structure['outer']['fields'][1][] = array('label' => 'Description');
$structure['outer']['fields'][1][] = array('field' => 'rdc_selection_desc', 'size' => 50, 'colspan' => 2);
$structure['outer']['fields'][1][] = array('field' => 'button_group');

$structure['outer']['fields'][2][] = array('label' => 'rdc_limit');
$structure['outer']['fields'][2][] = array('field' => 'rdc_limit');
$structure['outer']['fields'][2][] = array('label' => 'rdc_offset');
$structure['outer']['fields'][2][] = array('field' => 'rdc_offset');

$structure['tables']['inner'] = '#tablename#';

// identify the column specs - may use 'width' or 'class'
$structure['inner']['columns'][] = array('width' => '16.7%', 'align' => 'right');
$structure['inner']['columns'][] = array('width' => '8.4%');
$structure['inner']['columns'][] = array('width' => '8.4%');
$structure['inner']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['inner']['fields'][] = array('fieldname' => 'Field Name');
$structure['inner']['fields'][] = array('selected' => 'Selected');
$structure['inner']['fields'][] = array('sort_seq' => 'Sort Seq');
$structure['inner']['fields'][] = array('output_name' => 'Label');

?>