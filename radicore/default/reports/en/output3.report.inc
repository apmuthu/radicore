<?php
// report structure for a DETAIL view

$structure['pdf'] = array('orientation' => 'P',     // L=Landscape, P=Portrait
                          'units' => 'mm',          // pt=Point, mm=Millimeter, cm=Centimeter, in=Inch
                          'format' => 'A4',         // A3, A4, A5, Letter, Legal
                          'name' => '',             // filename (if destination = D or F)
                          'destination' => 'I');    // I=Inline (browser), D=Download (browser), F=Filename (on server), S=String

$structure['title']['style'] = 'title';             // style for page title
$structure['label']['style'] = 'label';             // style for field labels
$structure['data']['style']  = 'data';              // style for field data
$structure['foot']['style']  = 'foot';              // style for page footer

// define contents of page title
$structure['title'][] = array('type' => 'text',
                              'value' => "- page title -",
                              'width' => 70,
                              'align' => 'center',
                              'border' => 'y',
                              'x' => 70);

// set column widths for lines of format 1
$structure['columns'][] = array('width' => 40, 'halign' => 'right');
$structure['columns'][] = array('width' => 150, 'halign' => 'left');

// identify labels and data to be output

// format 1: one field and label per line
$structure['body']['fields'][] = array('field1' => 'Label 1');
$structure['body']['fields'][] = array('field2' => 'Label 2');
$structure['body']['fields'][] = array('field3' => 'Label 3');
$structure['body']['fields'][] = array('field4' => 'Label 4');

// format 2: contains lines with more than one field
$structure['body']['fields'][1] = array('field1' => 'Label 1');
$structure['body']['fields'][2][] = array('label' => 'Label 1', 'width' => 40);
$structure['body']['fields'][2][] = array('field' => 'field1', 'width' => 30);
$structure['body']['fields'][2][] = array('label' => 'Label 2', 'width' => 30);
$structure['body']['fields'][2][] = array('field' => 'field2', 'width' => 30);
$structure['body']['fields'][2][] = array('label' => 'Label 3', 'width' => 30);
$structure['body']['fields'][2][] = array('field' => 'field3', 'width' => 30);
// it is possible to have mixtures of format 1 and 2 on different lines
$structure['body']['fields'][3] = array('field1' => 'Label 1');
$structure['body']['fields'][4] = array('field2' => 'Label 2');
$structure['body']['fields'][5][] = array('label' => 'Label 1', 'width' => 40);
$structure['body']['fields'][5][] = array('field' => 'field1', 'width' => 30);
$structure['body']['fields'][5][] = array('label' => 'Label 2', 'width' => 30);
$structure['body']['fields'][5][] = array('field' => 'field2', 'width' => 30);
$structure['body']['fields'][6] = array('field1' => 'Label 1');

// define contents of page footer
$structure['foot1'][] = array('type' => 'date', 'align' => 'left', 'style' => 'textalignleft');
$structure['foot1'][] = array('type' => 'pageno', 'align' => 'center');
$structure['foot1'][] = array('type' => 'time', 'align' => 'right', 'style' => 'textalignright');
$structure['foot2'][] = array('text' => 'This is a piece of text', 'align' => 'center');

?>