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
$structure['title'][] = array('text' => '- Contents of DICT_DATABASE table -',
                              'width' => 100,
                              'align' => 'center',
                              'border' => 'y');

// set column widths
$structure['columns'][] = array('width' => 35);
$structure['columns'][] = array('width' => 80);
$structure['columns'][] = array('width' => 132);
$structure['columns'][] = array('width' => 30);

// identify column names and associated labels
$structure['body']['fields'][] = array('database_id' => 'Database Id');
$structure['body']['fields'][] = array('database_desc' => 'Description');
$structure['body']['fields'][] = array('db_comment' => 'Comment');
$structure['body']['fields'][] = array('subsys_id' => 'Subsys Id');

// define contents of page footer
$structure['foot1'][] = array('type' => 'date', 'align' => 'left', 'halign' => 'left');
$structure['foot1'][] = array('type' => 'pageno', 'align' => 'center');
$structure['foot1'][] = array('type' => 'time', 'align' => 'right', 'halign' => 'right');

$structure['foot2'][] = array('text' => 'Radicore Software Limited', 'align' => 'center');

?>