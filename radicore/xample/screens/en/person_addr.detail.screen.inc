<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'x_person_addr';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '75');
$structure['main']['columns'][] = array('width' => '75');
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][1][] = array('label' => 'Id');
$structure['main']['fields'][1][] = array('field' => 'person_id');
$structure['main']['fields'][1][] = array('label' => 'Name');
$structure['main']['fields'][1][] = array('field' => 'person_name');

$structure['main']['fields'][] = array('address_no' => 'Address No.', 'colspan' => 3);
$structure['main']['fields'][] = array('addr_line_1' => 'Address Line 1', 'colspan' => 3);
$structure['main']['fields'][] = array('addr_line_2' => 'Address Line 2', 'colspan' => 3);
$structure['main']['fields'][] = array('addr_line_3' => 'Address Line 3', 'colspan' => 3);
$structure['main']['fields'][] = array('town' => 'Town', 'colspan' => 3);
$structure['main']['fields'][] = array('county' => 'County', 'colspan' => 3);
$structure['main']['fields'][] = array('postcode' => 'Postcode', 'colspan' => 3);
$structure['main']['fields'][] = array('telephone_no' => 'Telephone No.', 'colspan' => 3);
$structure['main']['fields'][] = array('fax_no' => 'FAX No.', 'colspan' => 3);
$structure['main']['fields'][] = array('start_date' => 'Start Date', 'colspan' => 3);
$structure['main']['fields'][] = array('end_date' => 'End Date', 'colspan' => 3);
$structure['main']['fields'][] = array('created_date' => 'Created Date', 'colspan' => 3);
$structure['main']['fields'][] = array('created_user' => 'Created By', 'colspan' => 3);
$structure['main']['fields'][] = array('revised_date' => 'Revised Date', 'colspan' => 3);
$structure['main']['fields'][] = array('revised_user' => 'Revised By', 'colspan' => 3);

?>