<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'x_person';

$structure['main']['columns'][] = array('width' => 185);
$structure['main']['columns'][] = array('width' => 180);
$structure['main']['columns'][] = array('width' => 115);
$structure['main']['columns'][] = array('width' => 180);
$structure['main']['columns'][] = array('width' => 45);
$structure['main']['columns'][] = array('width' => 45);

$structure['main']['fields'][1] = array('person_id' => 'Id', 'colspan' => 5);

$structure['main']['fields'][2][] = array('label' => 'First Name');
$structure['main']['fields'][2][] = array('field' => 'first_name', 'size' => 15);
$structure['main']['fields'][2][] = array('label' => 'Last Name');
$structure['main']['fields'][2][] = array('field' => 'last_name', 'size' => 15);
$structure['main']['fields'][2][] = array('label' => 'Initials');
$structure['main']['fields'][2][] = array('field' => 'initials');

$structure['main']['fields'][4] = array('picture' => 'Picture', 'colspan' => 5);
$structure['main']['fields'][5] = array('nat_ins_no' => 'Nat. Ins. No.', 'colspan' => 5);
$structure['main']['fields'][6] = array('pers_type_id' => 'Person Type', 'colspan' => 5);
$structure['main']['fields'][7] = array('star_sign' => 'Star Sign', 'colspan' => 5);
$structure['main']['fields'][8] = array('node_id' => 'Organisation', 'colspan' => 5);
$structure['main']['fields'][9] = array('email_addr' => 'E-mail', 'colspan' => 5);
$structure['main']['fields'][10] = array('value1' => 'Value 1', 'colspan' => 5);
$structure['main']['fields'][11] = array('value2' => 'Value 2', 'colspan' => 5);
$structure['main']['fields'][12] = array('last_addr_no' => 'Last Address No', 'colspan' => 5);

$structure['main']['fields'][13][] = array('label' => 'Start Date');
$structure['main']['fields'][13][] = array('field' => 'start_date');
$structure['main']['fields'][13][] = array('label' => 'End Date');
$structure['main']['fields'][13][] = array('field' => 'end_date', 'colspan' => 3);

$structure['main']['fields'][] = array('created_date' => 'Created Date', 'colspan' => 5);
$structure['main']['fields'][] = array('created_user' => 'Created By', 'colspan' => 5);
$structure['main']['fields'][] = array('revised_date' => 'Revised Date', 'colspan' => 5);
$structure['main']['fields'][] = array('revised_user' => 'Revised By', 'colspan' => 5);
$structure['main']['fields'][] = array('selected' => 'Selected', 'colspan' => 5);

?>