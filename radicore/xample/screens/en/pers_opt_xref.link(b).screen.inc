<?php
$structure['xsl_file'] = 'std.link1.xsl';

$structure['tables']['outer'] = 'x_option';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('option_desc' => 'Option');

$structure['tables']['link'] = 'x_pers_opt_xref';

$structure['link']['columns'][] = array('width' => 5);
$structure['link']['columns'][] = array('width' => 75);
$structure['link']['columns'][] = array('width' => 125);
$structure['link']['columns'][] = array('width' => 125);
$structure['link']['columns'][] = array('width' => 100);
$structure['link']['columns'][] = array('width' => '*');

$structure['link']['fields'][] = array('selectbox' => 'Select');
$structure['link']['fields'][] = array('person_id' => 'Id');
$structure['link']['fields'][] = array('first_name' => 'First Name');
$structure['link']['fields'][] = array('last_name' => 'Last Name');
$structure['link']['fields'][] = array('star_sign' => 'Star Sign');
$structure['link']['fields'][] = array('null' => '');

?>