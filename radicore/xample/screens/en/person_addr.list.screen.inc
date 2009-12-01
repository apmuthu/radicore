<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'x_person';

$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => 100);
$structure['outer']['columns'][] = array('width' => 50);
$structure['outer']['columns'][] = array('width' => '*');

$structure['outer']['fields'][1][] = array('label' => 'Id');
$structure['outer']['fields'][1][] = array('field' => 'person_id');
$structure['outer']['fields'][1][] = array('label' => 'Name');
$structure['outer']['fields'][1][] = array('field' => 'person_name');

$structure['tables']['inner'] = 'x_person_addr';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 20);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 150);
$structure['inner']['columns'][] = array('width' => 100);
$structure['inner']['columns'][] = array('width' => 100);

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('address_no' => '#');
$structure['inner']['fields'][] = array('town' => 'Town');
$structure['inner']['fields'][] = array('county' => 'County');
$structure['inner']['fields'][] = array('postcode' => 'Postcode');
$structure['inner']['fields'][] = array('start_date' => 'Start Date');

?>