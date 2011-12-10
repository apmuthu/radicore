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
$structure['title'][] = array('text' => '- Contents of MNU_TASK table -',
                              'width' => 100,
                              'align' => 'center',
                              'border' => 'y');

// set column widths
$structure['columns'][] = array('width' => 60);
$structure['columns'][] = array('width' => 130);
$structure['columns'][] = array('width' => 30);
$structure['columns'][] = array('width' => 30);
$structure['columns'][] = array('width' => 25, 'halign' => 'center');

// identify column names and associated labels
$structure['body']['fields'][] = array('task_id' => 'Task Id');
$structure['body']['fields'][] = array('task_desc' => 'Description');
$structure['body']['fields'][] = array('subsys_id' => 'Subsys Id');
$structure['body']['fields'][] = array('pattern_id' => 'Pattern Id');
$structure['body']['fields'][] = array('task_type' => 'Task Type');

// define contents of page footer
$structure['foot1'][] = array('type' => 'date',   'align' => 'left',   'halign' => 'left');
$structure['foot1'][] = array('type' => 'pageno', 'align' => 'center', 'margin_left' => 8.5);
$structure['foot1'][] = array('type' => 'time',   'align' => 'right',  'halign' => 'right');

$structure['foot2'][] = array('text' => 'Radicore Software Limited', 'align' => 'center');

?>