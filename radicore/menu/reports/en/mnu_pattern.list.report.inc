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
$structure['title'][] = array('text' => '- Contents of MNU_PATTERN table -',
                              'width' => 100,
                              'align' => 'center',
                              'border' => 'y');

// set column widths
$structure['columns'][] = array('width' => 42);
$structure['columns'][] = array('width' => 145);
$structure['columns'][] = array('width' => 25, 'halign' => 'center');
$structure['columns'][] = array('width' => 25, 'halign' => 'center');
$structure['columns'][] = array('width' => 25, 'halign' => 'center');
$structure['columns'][] = array('width' => 15, 'halign' => 'right');

// identify column names and associated labels
$structure['body']['fields'][] = array('pattern_id' => 'Pattern Id');
$structure['body']['fields'][] = array('pattern_desc' => 'Description');
$structure['body']['fields'][] = array('visible_screen' => 'Visible?');
$structure['body']['fields'][] = array('context_preselect' => 'Preselect?');
$structure['body']['fields'][] = array('keep_data' => 'Keep Data?');
$structure['body']['fields'][] = array('count' => 'Count');

// define contents of page footer
$structure['foot1'][] = array('type' => 'date', 'align' => 'left', 'halign' => 'left');
$structure['foot1'][] = array('type' => 'pageno', 'align' => 'center');
$structure['foot1'][] = array('type' => 'time', 'align' => 'right', 'halign' => 'right');

$structure['foot2'][] = array('text' => 'Radicore Software Limited', 'align' => 'center');

?>