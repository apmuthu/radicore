<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'uom_category';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '25%');

// identify the field names and their screen labels
$structure['outer']['fields'][] = array('uom_cat_desc' => 'UOM Category');

$structure['tables']['inner'] = 'unit_of_measure';

// identify the column specs - may use 'width' or 'class'
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 50);

// identify the field names and their screen labels
$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('uom_desc' => 'Description');
$structure['inner']['fields'][] = array('uom_abbrev' => 'Abbreviation');

?>