<?php
// report structure for a LIST view

$structure['pdf'] = array('orientation' => 'L',     // L=Landscape, P=Portrait
                          'units' => 'mm',          // pt=Point, mm=Millimeter, cm=Centimeter, in=Inch
                          'format' => 'A4',         // A3, A4, A5, Letter, Legal
                          'name' => '',             // filename (if destination = D or F)
                          'destination' => 'I');    // I=Inline (browser), D=Download (browser), F=Filename (on server), S=String

$structure['title']['style'] = 'title';             // style for page title
$structure['head']['style']  = 'hdg';               // style for column headings
$structure['body']['style']  = 'body';              // style for main body
$structure['foot']['style']  = 'foot';              // style for page footer

// define contents of page title
$structure['title'][] = array('text' => '- Contents of X_PERSON table -',
                              'width' => 100,
                              'align' => 'center',
                              'border' => 'y');

// set column widths
$structure['columns'][] = array('width' => 22);
$structure['columns'][] = array('width' => 30);
$structure['columns'][] = array('width' => 30);
$structure['columns'][] = array('width' => 20);
$structure['columns'][] = array('width' => 30);
$structure['columns'][] = array('width' => 55);
$structure['columns'][] = array('width' => 25);
$structure['columns'][] = array('width' => 25);
$structure['columns'][] = array('width' => 20, 'align' => 'right');
$structure['columns'][] = array('width' => 20, 'align' => 'right');

// identify column names and associated labels
$structure['body']['fields'][] = array('person_id' => 'Id');
$structure['body']['fields'][] = array('first_name' => 'First Name');
$structure['body']['fields'][] = array('last_name' => 'Last Name');
$structure['body']['fields'][] = array('initials' => 'Initials');
$structure['body']['fields'][] = array('star_sign' => 'Star Sign');
$structure['body']['fields'][] = array('pers_type_desc' => 'Person Type');
$structure['body']['fields'][] = array('nat_ins_no' => 'N.I. No');
$structure['body']['fields'][] = array('start_date' => 'Start Date');
$structure['body']['fields'][] = array('value1' => 'Value 1');
$structure['body']['fields'][] = array('value2' => 'Value 2');

// define contents of page footer
$structure['foot1'][] = array('type' => 'date', 'align' => 'left', 'style' => 'textalignleft');
$structure['foot1'][] = array('type' => 'pageno', 'align' => 'center');
$structure['foot1'][] = array('type' => 'time', 'align' => 'right', 'style' => 'textalignright');

$structure['foot2'][] = array('text' => 'Radicore Software Limited', 'align' => 'center');

?>