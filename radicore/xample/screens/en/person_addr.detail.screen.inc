<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'x_person_addr';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => 250);

$structure['main']['fields'][] = array('person_id' => 'Id');
$structure['main']['fields'][] = array('person_name' => 'Name');
$structure['main']['fields'][] = array('address_no' => 'Address No.');
$structure['main']['fields'][] = array('addr_line_1' => 'Address Line 1');
$structure['main']['fields'][] = array('addr_line_2' => 'Address Line 2');
$structure['main']['fields'][] = array('addr_line_3' => 'Address Line 3');
$structure['main']['fields'][] = array('town' => 'Town');
$structure['main']['fields'][] = array('county' => 'County');
$structure['main']['fields'][] = array('postcode' => 'Postcode');
$structure['main']['fields'][] = array('telephone_no' => 'Telephone No.');
$structure['main']['fields'][] = array('fax_no' => 'FAX No.');
$structure['main']['fields'][] = array('start_date' => 'Start Date');
$structure['main']['fields'][] = array('end_date' => 'End Date');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>