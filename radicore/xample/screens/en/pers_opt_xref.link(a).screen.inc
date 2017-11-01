<?php
$structure['xsl_file'] = 'std.link1.xsl';

$structure['tables']['outer'] = 'x_person';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('person_name' => 'Person');

$structure['tables']['link'] = 'x_pers_opt_xref';

$structure['link']['columns'][] = array('width' => 5);
$structure['link']['columns'][] = array('width' => 100);
$structure['link']['columns'][] = array('width' => 250);
$structure['link']['columns'][] = array('width' => '*');

$structure['link']['fields'][] = array('selectbox' => 'Select');
$structure['link']['fields'][] = array('option_id' => 'Id');
$structure['link']['fields'][] = array('option_desc' => 'Description');
$structure['link']['fields'][] = array('null' => '');

?>