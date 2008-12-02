<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'x_option';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['outer']['fields'][] = array('option_desc' => 'Option');

$structure['tables']['inner'] = 'x_option_alt';

// identify the column specs - may use 'width' or 'class'
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 150);
$structure['inner']['columns'][] = array('width' => 350);
$structure['inner']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('language_id' => 'Language');
$structure['inner']['fields'][] = array('option_desc' => 'Description');
$structure['inner']['fields'][] = array('' => '');

?>