<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'unit_of_measure';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('uom_desc' => 'FROM Unit');

$structure['tables']['inner'] = 'uom_conversion';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 75);
$structure['inner']['columns'][] = array('width' => '*');

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('conversion_factor' => 'Factor');
$structure['inner']['fields'][] = array('uom_id_to' => 'TO Unit');

?>