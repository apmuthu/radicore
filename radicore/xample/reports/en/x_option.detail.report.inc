<?php
// report structure for a DETAIL view

$structure['pdf'] = array('orientation' => 'P',     // L=Landscape, P=Portrait
                          'units' => 'mm',          // pt=Point, mm=Millimeter, cm=Centimeter, in=Inch
                          'format' => 'A4',         // A3, A4, A5, Letter, Legal
                          'name' => '',             // filename (if destination = D or F)
                          'destination' => 'I');    // I=Inline (browser), D=Download (browser), F=Filename (on server), S=String

//$structure['title']['style'] = 'title';             // style for page title
$structure['label']['style'] = 'label';             // style for field labels
$structure['data']['style']  = 'data';              // style for field data
$structure['foot']['style']  = 'foot';              // style for page footer

// supply text for ADDRESS1 and ADDRESS2
//$structure['title'][] = array('text' => '%%address1',
//                              'width' => 90,
//                              'style' => 'address',
//                              'x' => 2,
//                              'y_relative' => 1);
//
//$structure['title'][] = array('text' => '%%address2',
//                              'width' => 90,
//                              'style' => 'address',
//                              'marginleft' => 8);

// paint empty boxes for ADDRESS1 and ADDRESS2
//$structure['title'][] = array('text' => '',
//                              'nofill' => 'y',
//                              'width' => 92,
//                              'height' => 34,
//                              'border' => 'y',
//                              'align' => 'left',
//                              'y_relative' => -1);
//
//$structure['title'][] = array('text' => '',
//                              'nofill' => 'y',
//                              'width' => 92,
//                              'height' => 34,
//                              'border' => 'y',
//                              'align' => 'r1ght',
//                              'newline' => 'y');


$structure['columns'][] = array('width' => '50%', 'align' => 'left');
$structure['columns'][] = array('width' => '50%', 'align' => 'left');

$structure['body']['fields'][1][] = array('field' => 'address1', 'width' => '49%', 'style' => 'address', 'min_lines' => 7);
$structure['body']['fields'][1][] = array('field' => '', 'width' => '2%', 'style' => 'noborder');
$structure['body']['fields'][1][] = array('field' => 'address2', 'width' => '49%', 'style' => 'address', 'min_lines' => 7);

$structure['body']['fields'][2][] = array('field' => 'filler', 'width' => '100%', 'style' => 'noborder');

$structure['body']['fields'][3][] = array('field' => 'address3', 'width' => '49%', 'style' => 'address', 'min_lines' => 7);
$structure['body']['fields'][3][] = array('field' => '', 'width' => '2%', 'style' => 'noborder');
$structure['body']['fields'][3][] = array('field' => 'address4', 'width' => '49%', 'style' => 'address', 'min_lines' => 7);




// define contents of page title
//$structure['title'][] = array('text' => "- Contents of X_OPTION table -",
//                              'width' => 70,
//                              'align' => 'center',
//                              'border' => 'y',
//                              'x' => 70);

// set column widths for lines of format 1
//$structure['columns'][] = array('width' => 40, 'halign' => 'right');
//$structure['columns'][] = array('width' => 150, 'halign' => 'left');

// identify labels and data to be output

// format 1: one field and label per line
//$structure['body']['fields'][] = array('option_id' => 'Option Id');
//$structure['body']['fields'][] = array('option_desc' => 'Option Description');
//$structure['body']['fields'][] = array('created_date' => 'Created Date');
//$structure['body']['fields'][] = array('created_user' => 'Created User');
//$structure['body']['fields'][] = array('revised_date' => 'Revised Date');
//$structure['body']['fields'][] = array('revised_user' => 'Revised User');

// format 2: contains lines with more than one field
// it is possible to have mixtures of format 1 and 2 on different lines

// define contents of page footer
//$structure['foot1'][] = array('type' => 'date', 'align' => 'left', 'style' => 'textalignleft');
//$structure['foot1'][] = array('type' => 'pageno', 'align' => 'center');
//$structure['foot1'][] = array('type' => 'time', 'align' => 'right', 'style' => 'textalignright');
//$structure['foot2'][] = array('text' => 'This is a piece of text', 'align' => 'center');

?>