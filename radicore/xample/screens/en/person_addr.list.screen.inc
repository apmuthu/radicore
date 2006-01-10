<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'x_person';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('person_name' => 'Person');

$structure['tables']['inner'] = 'x_person_addr';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 10);
$structure['inner']['columns'][] = array('width' => 100);
$structure['inner']['columns'][] = array('width' => 100);
$structure['inner']['columns'][] = array('width' => 100);
$structure['inner']['columns'][] = array('width' => 100);

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('address_no' => '#');
$structure['inner']['fields'][] = array('town' => 'Town');
$structure['inner']['fields'][] = array('county' => 'County');
$structure['inner']['fields'][] = array('postcode' => 'Postcode');
$structure['inner']['fields'][] = array('start_date' => 'Start Date');

?>