<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'x_person';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => 100);
$structure['outer']['columns'][] = array('width' => 50);
$structure['outer']['columns'][] = array('width' => '*');

$structure['outer']['fields'][1][] = array('label' => 'Id');
$structure['outer']['fields'][1][] = array('field' => 'person_id');
$structure['outer']['fields'][1][] = array('label' => 'Name');
$structure['outer']['fields'][1][] = array('field' => 'person_name');

$structure['tables']['inner'] = 'x_person_addr';

// identify the column specs - may use 'width' or 'class'
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => '6.25%');
$structure['inner']['columns'][] = array('width' => '6.25%');
$structure['inner']['columns'][] = array('width' => '6.25%');
$structure['inner']['columns'][] = array('width' => '6.25%');
$structure['inner']['columns'][] = array('width' => '6.25%');
$structure['inner']['columns'][] = array('width' => '6.25%');
$structure['inner']['columns'][] = array('width' => '6.25%');
$structure['inner']['columns'][] = array('width' => '6.25%');

// identify the field names and their screen labels
$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('address_no' => '#');
$structure['inner']['fields'][] = array('telephone_no' => 'Telephone No');
$structure['inner']['fields'][] = array('fax_no' => 'Fax No');
$structure['inner']['fields'][] = array('addr_line_1' => 'Addr Line 1');
$structure['inner']['fields'][] = array('addr_line_2' => 'Addr Line 2');
$structure['inner']['fields'][] = array('addr_line_3' => 'Addr Line 3');
$structure['inner']['fields'][] = array('town' => 'Town');
$structure['inner']['fields'][] = array('county' => 'County');
$structure['inner']['fields'][] = array('postcode' => 'Postcode');

?>
