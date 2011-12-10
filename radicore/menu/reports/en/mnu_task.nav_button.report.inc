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
$structure['title'][] = array('text' => '- Contents of MNU_NAV_BUTTON table -',
                              'width' => 100,
                              'align' => 'center',
                              'border' => 'y');

// set column widths
$structure['columns'][] = array('width' => 40, 'halign' => 'right');
$structure['columns'][] = array('width' => 150, 'halign' => 'left');

// identify labels and data to be output

// format 1: one field and label per line
$structure['body']['fields'][] = array('task_id' => 'Task Id');
$structure['body']['fields'][] = array('task_desc' => 'Description');

// define contents of page footer
$structure['foot1'][] = array('type' => 'date',   'align' => 'left',  'halign' => 'left');
$structure['foot1'][] = array('type' => 'pageno', 'align' => 'center', 'margin_left' => 8.5);
$structure['foot1'][] = array('type' => 'time',   'align' => 'right',  'halign' => 'right');

$structure['foot2'][] = array('text' => 'Radicore Software Limited', 'align' => 'center');

// identify output for 1st additional zone
$structure['multi1']['fields'][1][] = array('label' => 'Seq', 'width' => 10, 'halign' => 'center');
$structure['multi1']['fields'][1][] = array('label' => 'Nav Button', 'width' => 50, 'halign' => 'center');
$structure['multi1']['fields'][1][] = array('label' => 'Button Description', 'width' => 90, 'halign' => 'center');
$structure['multi1']['fields'][1][] = array('label' => 'Button Text', 'width' => 40, 'halign' => 'center');

// identify output for 2nd additional zone
$structure['multi2']['fields'][1][] = array('field' => 'sort_seq', 'width' => 10, 'halign' => 'center');
$structure['multi2']['fields'][1][] = array('field' => 'task_id_jnr', 'width' => 50);
$structure['multi2']['fields'][1][] = array('field' => 'task_desc_jnr', 'width' => 90);
$structure['multi2']['fields'][1][] = array('field' => 'button_text', 'width' => 40);

?>