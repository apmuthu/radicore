<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'x_option';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('option_desc' => 'Option');

$structure['tables']['inner'] = 'x_pers_opt_xref';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 75);
$structure['inner']['columns'][] = array('width' => 125);
$structure['inner']['columns'][] = array('width' => 125);
$structure['inner']['columns'][] = array('width' => 100);
$structure['inner']['columns'][] = array('width' => '*');

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('person_id' => 'Id');
$structure['inner']['fields'][] = array('first_name' => 'First Name');
$structure['inner']['fields'][] = array('last_name' => 'Last Name');
$structure['inner']['fields'][] = array('star_sign' => 'Star Sign');
$structure['inner']['fields'][] = array('null' => '');

?>