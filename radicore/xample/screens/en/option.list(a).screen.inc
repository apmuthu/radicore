<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'x_person';

$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '*');

$structure['outer']['fields'][] = array('person_name' => 'Person');

$structure['tables']['inner'] = 'x_pers_opt_xref';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 100);
$structure['inner']['columns'][] = array('width' => 350);
$structure['inner']['columns'][] = array('width' => '*');

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('option_id' => 'Id');
$structure['inner']['fields'][] = array('option_desc' => 'Description');
$structure['inner']['fields'][] = array('null' => '');

?>