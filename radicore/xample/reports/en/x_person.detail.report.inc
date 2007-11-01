<?php
// report structure for a DETAIL view

$structure['pdf'] = array('orientation' => 'P',     // L=Landscape, P=Portrait
                          'units' => 'mm',          // pt=Point, mm=Millimeter, cm=Centimeter, in=Inch
                          'format' => 'A4',         // A3, A4, A5, Letter, Legal
                          'name' => '',             // filename (if destination = D or F)
                          'destination' => 'I');    // I=Inline (browser), D=Download (browser), F=Filename (on server), S=String

$structure['title']['style'] = 'title';             // style for page heading
$structure['label']['style'] = 'label';             // style for field labels
$structure['data']['style']  = 'data';              // style for field data
$structure['foot']['style']  = 'foot';              // style for page footer

// define contents of page title
$structure['title'][] = array('text' => 'Contents of X_PERSON table',
                              'width' => 80,
                              'align' => 'center',
                              'border' => 'y',
                              'newline' => 'y');

// set column widths
$structure['columns'][] = array('width' => 40, 'align' => 'right');
$structure['columns'][] = array('width' => 150, 'align' => 'left');

// this example has more than one column to a line
$structure['body']['fields'][1][] = array('label' => 'Id', 'width' => 40);
$structure['body']['fields'][1][] = array('field' => 'person_id', 'width' => 30);
$structure['body']['fields'][1][] = array('label' => 'Barcode', 'width' => 30);
$structure['body']['fields'][1][] = array('barcode' => 'barcode', 'barcode_style' => 'barcode1', 'width' => 90, 'height' => 25);

//$structure['body']['fields'][1][] = array('label' => 'Barcode', 'width' => 30);
//$structure['body']['fields'][1][] = array('barcode' => 'barcode', 'barcode_style' => 'barcode1', 'width' => 90, 'height' => 25);
//$structure['body']['fields'][1][] = array('label' => 'Id', 'width' => 40);
//$structure['body']['fields'][1][] = array('field' => 'person_id', 'width' => 30);

$structure['body']['fields'][2][] = array('label' => 'First Name', 'width' => 40);
$structure['body']['fields'][2][] = array('field' => 'first_name', 'width' => 30);
$structure['body']['fields'][2][] = array('label' => 'Last Name', 'width' => 30);
$structure['body']['fields'][2][] = array('field' => 'last_name', 'width' => 30);
$structure['body']['fields'][2][] = array('label' => 'Initials', 'width' => 30);
$structure['body']['fields'][2][] = array('field' => 'initials', 'width' => 30);

$structure['body']['fields'][4] = array('picture' => 'Picture');
$structure['body']['fields'][5] = array('nat_ins_no' => 'Nat. Ins. No.');
$structure['body']['fields'][6] = array('pers_type_id' => 'Person Type');
$structure['body']['fields'][7] = array('star_sign' => 'Star Sign');
$structure['body']['fields'][8] = array('node_id' => 'Organisation');
$structure['body']['fields'][9] = array('email_addr' => 'E-mail');
$structure['body']['fields'][10] = array('favourite_food' => 'Favourite Food');

$structure['body']['fields'][11][] = array('label' => 'Value 1', 'width' => 40);
$structure['body']['fields'][11][] = array('field' => 'value1', 'width' => 50);
$structure['body']['fields'][11][] = array('label' => 'Value 2', 'width' => 50);
$structure['body']['fields'][11][] = array('field' => 'value2', 'width' => 50);

$structure['body']['fields'][12] = array('last_addr_no' => 'Last Address No');

$structure['body']['fields'][13][] = array('label' => 'Start Date', 'width' => 40);
$structure['body']['fields'][13][] = array('field' => 'start_date', 'width' => 50);
$structure['body']['fields'][13][] = array('label' => 'End Date', 'width' => 50);
$structure['body']['fields'][13][] = array('field' => 'end_date', 'width' => 50);

$structure['body']['fields'][14][] = array('label' => 'Created Date', 'width' => 40);
$structure['body']['fields'][14][] = array('field' => 'created_date', 'width' => 50);
$structure['body']['fields'][14][] = array('label' => 'Created By', 'width' => 50);
$structure['body']['fields'][14][] = array('field' => 'created_user', 'width' => 50);

$structure['body']['fields'][15][] = array('label' => 'Revised Date', 'width' => 40);
$structure['body']['fields'][15][] = array('field' => 'revised_date', 'width' => 50);
$structure['body']['fields'][15][] = array('label' => 'Revised By', 'width' => 50);
$structure['body']['fields'][15][] = array('field' => 'revised_user', 'width' => 50);

// define contents of page footer
$structure['foot1'][] = array('type' => 'date', 'align' => 'left', 'style' => 'textalignleft');
$structure['foot1'][] = array('type' => 'pageno', 'align' => 'center');
$structure['foot1'][] = array('type' => 'time', 'align' => 'right', 'style' => 'textalignright');

$structure['foot2'][] = array('text' => 'Radicore Software Limited', 'align' => 'center');

// identify output for 1st additional zone
$structure['multi1']['fields'][1][] = array('label' => '#', 'width' => 10, 'align' => 'center');
$structure['multi1']['fields'][1][] = array('label' => 'Address', 'width' => 80, 'align' => 'center');
$structure['multi1']['fields'][1][] = array('label' => 'Telephone', 'width' => 40, 'align' => 'center');
$structure['multi1']['fields'][1][] = array('label' => 'Start', 'width' => 30, 'align' => 'center');
$structure['multi1']['fields'][1][] = array('label' => 'End', 'width' => 30, 'align' => 'center');

// identify output for 2nd additional zone
$structure['multi2']['fields'][1][] = array('field' => 'address_no', 'width' => 10, 'align' => 'center');
$structure['multi2']['fields'][1][] = array('field' => 'address_long', 'width' => 80);
$structure['multi2']['fields'][1][] = array('field' => 'telephone_no', 'width' => 40);
$structure['multi2']['fields'][1][] = array('field' => 'start_date', 'width' => 30);
$structure['multi2']['fields'][1][] = array('field' => 'end_date', 'width' => 30);

?>