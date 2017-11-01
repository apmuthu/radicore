<?php
// report structure for a LIST view

$structure['pdf'] = array('orientation' => 'L',     // L=Landscape, P=Portrait
                          'units' => 'mm',          // pt=Point, mm=Millimeter, cm=Centimeter, in=Inch
                          'format' => 'A4',         // A3, A4, A5, Letter, Legal
                          'name' => '',             // filename (if destination = D or F)
                          'marginbottom' => 15,     // page bottom margin
                          'destination' => 'I');    // I=Inline (browser), D=Download (browser), F=Filename (on server), S=String

$structure['title']['style'] = 'title';             // style for page title
$structure['head']['style']  = 'hdg';               // style for column headings
$structure['body']['style']  = 'body';              // style for main body
$structure['foot']['style']  = 'foot';              // style for page footer

// define contents of page title
$structure['title'][] = array('text' => "- Contents of X_OPTION table -",
                              'width' => 100,
                              'align' => 'center',
                              'border' => 'y');

// set column widths
$structure['columns'][] = array('width' => '*');
$structure['columns'][] = array('width' => '*');
$structure['columns'][] = array('width' => '*');
$structure['columns'][] = array('width' => '*');
$structure['columns'][] = array('width' => '*');
$structure['columns'][] = array('width' => '*');

// identify column names and associated labels
$structure['body']['fields'][] = array('option_id' => 'Option Id');
$structure['body']['fields'][] = array('option_desc' => 'Option Description');
$structure['body']['fields'][] = array('created_date' => 'Created Date');
$structure['body']['fields'][] = array('created_user' => 'Created User');
$structure['body']['fields'][] = array('revised_date' => 'Revised Date');
$structure['body']['fields'][] = array('revised_user' => 'Revised User');

// define contents of page footer
$structure['foot1'][] = array('type' => 'date',   'align' => 'left',   'style' => 'textalignleft');
$structure['foot1'][] = array('type' => 'pageno', 'align' => 'center', 'style' => 'textaligncenter', 'margin_left' => 8.5);
$structure['foot1'][] = array('type' => 'time',   'align' => 'right',  'style' => 'textalignright');
$structure['foot2'][] = array('text' => 'This is a piece of text', 'align' => 'center');

?>