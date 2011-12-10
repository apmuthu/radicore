<?php
// report structure for the ADDRESS LABELS view

$structure['pdf'] = array('orientation' => 'P',     // L=Landscape, P=Portrait
                          'units' => 'mm',          // pt=Point, mm=Millimeter, cm=Centimeter, in=Inch
                          'format' => 'A4',         // A3, A4, A5, Letter, Legal
                          'name' => '',             // filename (if destination = D or F)
                          'destination' => 'I');    // I=Inline (browser), D=Download (browser), F=Filename (on server), S=String

$structure['pdf']['label_print'] = 3;               // defines the number of labels in each row

$structure['data']['style']  = 'address_labels';    // style for label data

//$structure['columns'][] = array('width' => '33%');
//$structure['columns'][] = array('width' => '33%');
//$structure['columns'][] = array('width' => '33%');
//
//$structure['body']['fields'][1][] = array('field' => 'address1', 'min_lines' => 8, 'marginright' => 1);
//$structure['body']['fields'][1][] = array('field' => 'address2', 'min_lines' => 8, 'marginright' => 1);
//$structure['body']['fields'][1][] = array('field' => 'address3', 'min_lines' => 8);


$structure['columns'][] = array('width' => '33%');
$structure['columns'][] = array('width' => '0.5%');
$structure['columns'][] = array('width' => '33%');
$structure['columns'][] = array('width' => '0.5%');
$structure['columns'][] = array('width' => '33%');

$structure['body']['fields'][1][] = array('field' => 'address1', 'min_lines' => 8);
$structure['body']['fields'][1][] = array('field' => '', 'style' => 'noborder');
$structure['body']['fields'][1][] = array('field' => 'address2', 'min_lines' => 8);
$structure['body']['fields'][1][] = array('field' => '', 'style' => 'noborder');
$structure['body']['fields'][1][] = array('field' => 'address3', 'min_lines' => 8);

?>