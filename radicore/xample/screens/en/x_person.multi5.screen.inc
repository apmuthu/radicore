<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'x_person_dummy';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '20%');
$structure['outer']['columns'][] = array('width' => '*');
$structure['outer']['columns'][] = array('width' => '*');
$structure['outer']['columns'][] = array('width' => '*');
$structure['outer']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['outer']['fields'][1][] = array('label' => 'Star Sign');
$structure['outer']['fields'][1][] = array('field' => 'star_sign');
$structure['outer']['fields'][1][] = array('label' => 'Person Type Id');
$structure['outer']['fields'][1][] = array('field' => 'pers_type_id');
$structure['outer']['fields'][1][] = array('field' => 'retrieve', 'align' => 'right');

$structure['tables']['inner'] = 'x_person';

// identify the column specs - may use 'width' or 'class'
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 125);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('person_id' => 'Person Id');
$structure['inner']['fields'][] = array('star_sign' => 'Star Sign');
$structure['inner']['fields'][] = array('first_name' => 'First Name');
$structure['inner']['fields'][] = array('last_name' => 'Last Name');
$structure['inner']['fields'][] = array('pers_type_desc' => 'Person Type');

?>
