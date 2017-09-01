<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'x_person';

$structure['main']['columns'][] = array('width' => '20%');
$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '15%');
$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '10%');
$structure['main']['columns'][] = array('width' => '10%');

// identify the field names and their screen labels
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

$structure['main']['fields'][10][] = array('label' => 'Value 1');
$structure['main']['fields'][10][] = array('field' => 'value1');
$structure['main']['fields'][10][] = array('label' => 'Favourite Food', 'rowspan' => 3);
$structure['main']['fields'][10][] = array('field' => 'favourite_food', 'colspan' => 3, 'rowspan' => 3);

// these next two fields fit to the left of 'favourite_food' and must be displayed, even when empty
$structure['main']['fields'][11][] = array('label' => 'Value 2');
$structure['main']['fields'][11][] = array('field' => 'value2', 'display-empty' => 'y');
$structure['main']['fields'][12][] = array('label' => 'Last Address No');
$structure['main']['fields'][12][] = array('field' => 'last_addr_no', 'display-empty' => 'y');

$structure['main']['fields'][13][] = array('label' => 'Start Date');
$structure['main']['fields'][13][] = array('field' => 'start_date');
$structure['main']['fields'][13][] = array('label' => 'End Date');
$structure['main']['fields'][13][] = array('field' => 'end_date', 'colspan' => 3);

$structure['main']['fields'][14][] = array('label' => 'Postcode');
$structure['main']['fields'][14][] = array('field' => 'postcode');
$structure['main']['fields'][14][] = array('label' => 'County');
$structure['main']['fields'][14][] = array('field' => 'county', 'colspan' => 3);

$structure['main']['fields'][15] = array('curr_or_hist' => 'Current or Historic', 'colspan' => 5);

$structure['main']['fields'][16][] = array('label' => '<- this is an orphan label ->', 
                                           'label-only' => 'y', 
                                           'align' => 'center', 
                                           'colspan' => 6);

$structure['main']['fields'][] = array('created_date' => 'Created Date', 'colspan' => 5);
$structure['main']['fields'][] = array('created_user' => 'Created By', 'colspan' => 5);
$structure['main']['fields'][] = array('revised_date' => 'Revised Date', 'colspan' => 5);
$structure['main']['fields'][] = array('revised_user' => 'Revised By', 'colspan' => 5);

// this is here for one of the search screens
$structure['main']['fields'][] = array('selected' => 'Selected', 'colspan' => 5);

?>