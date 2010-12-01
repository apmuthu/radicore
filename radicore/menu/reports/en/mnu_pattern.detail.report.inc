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
$structure['title'][] = array('text' => '- Contents of MNU_PATTERN table -',
                              'width' => 100,
                              'align' => 'center',
                              'border' => 'y');

// set column widths
$structure['columns'][] = array('width' => 40, 'halign' => 'right');
$structure['columns'][] = array('width' => 150, 'halign' => 'left');

// identify labels and data to be output

// format 1: one field and label per line
$structure['body']['fields'][] = array('pattern_id' => 'Pattern Id');
$structure['body']['fields'][] = array('pattern_desc' => 'Description');
$structure['body']['fields'][] = array('pattern_long_desc' => 'Long Description');
$structure['body']['fields'][] = array('visible_screen' => 'Visible Screen?');
$structure['body']['fields'][] = array('context_preselect' => 'Context Preselect?');
$structure['body']['fields'][] = array('keep_data' => 'Keep Data?');
$structure['body']['fields'][] = array('created_date' => 'Created Date');
$structure['body']['fields'][] = array('created_user' => 'Created By');
$structure['body']['fields'][] = array('revised_date' => 'Revised Date');
$structure['body']['fields'][] = array('revised_user' => 'Revised By');

// define contents of page footer
$structure['foot1'][] = array('type' => 'date', 'align' => 'left', 'style' => 'textalignleft');
$structure['foot1'][] = array('type' => 'pageno', 'align' => 'center');
$structure['foot1'][] = array('type' => 'time', 'align' => 'right', 'style' => 'textalignright');

$structure['foot2'][] = array('text' => 'Radicore Software Limited', 'align' => 'center');

?>