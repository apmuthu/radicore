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
$structure['title'][] = array('text' => '- Contents of MNU_ROLE table -',
                              'width' => 100,
                              'align' => 'center',
                              'border' => 'y');

// set column widths
$structure['columns'][] = array('width' => 42);
$structure['columns'][] = array('width' => 120);
$structure['columns'][] = array('width' => 80);
$structure['columns'][] = array('width' => 35, 'halign' => 'center');

// identify column names and associated labels
$structure['body']['fields'][] = array('role_id' => 'Role Id');
$structure['body']['fields'][] = array('role_desc' => 'Description');
$structure['body']['fields'][] = array('start_task_id' => 'Start Task');
$structure['body']['fields'][] = array('global_access' => "Global Access?");

// define contents of page footer
$structure['foot1'][] = array('type' => 'date', 'align' => 'left', 'halign' => 'left');
$structure['foot1'][] = array('type' => 'pageno', 'align' => 'center');
$structure['foot1'][] = array('type' => 'time', 'align' => 'right', 'halign' => 'right');

$structure['foot2'][] = array('text' => 'Radicore Software Limited', 'align' => 'center');

?>