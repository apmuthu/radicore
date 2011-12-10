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
$structure['title'][] = array('text' => "- <insert title here> -",
                              'width' => 100,
                              'align' => 'center',
                              'border' => 'y');

// set column widths
$structure['columns'][] = array('width' => 'n%');
$structure['columns'][] = array('width' => 25, 'halign' => 'left', 'overflow' => 'y');
$structure['columns'][] = array('width' => 20, 'halign' => 'right');
$structure['columns'][] = array('width' => 20, 'halign' => 'center');

// identify column names and associated labels
$structure['body']['fields'][] = array('field1' => 'Label1');
$structure['body']['fields'][] = array('field2' => 'Label2');
$structure['body']['fields'][] = array('field3' => 'Label3');
$structure['body']['fields'][] = array('field4' => 'Label4');

// define contents of page footer
$structure['foot1'][] = array('type' => 'date', 'align' => 'left', 'style' => 'textalignleft');
$structure['foot1'][] = array('type' => 'pageno', 'align' => 'center');
$structure['foot1'][] = array('type' => 'time', 'align' => 'right', 'style' => 'textalignright');
$structure['foot2'][] = array('text' => 'This is a piece of text', 'align' => 'center');

?>