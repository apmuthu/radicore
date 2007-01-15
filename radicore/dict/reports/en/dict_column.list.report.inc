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
$structure['title'][] = array('text' => '- Contents of DICT_COLUMN table -',
                              'width' => 100,
                              'align' => 'center',
                              'border' => 'y');

// set column widths
$structure['columns'][] = array('width' => 30);
$structure['columns'][] = array('width' => 40);
$structure['columns'][] = array('width' => 10, 'align' => 'center');
$structure['columns'][] = array('width' => 50);
$structure['columns'][] = array('width' => 50);
$structure['columns'][] = array('width' => 30);
$structure['columns'][] = array('width' => 15);
$structure['columns'][] = array('width' => 24);
$structure['columns'][] = array('width' => 29);

// identify column names and associated labels
$structure['body']['fields'][] = array('database_id' => 'Database Id');
$structure['body']['fields'][] = array('table_id' => 'Table Id');
$structure['body']['fields'][] = array('column_seq' => 'Seq');
$structure['body']['fields'][] = array('column_id' => 'Column Id');
$structure['body']['fields'][] = array('column_desc' => 'Description');
$structure['body']['fields'][] = array('col_type' => 'Type');
$structure['body']['fields'][] = array('col_maxsize' => 'Size');
$structure['body']['fields'][] = array('col_null' => 'Null');
$structure['body']['fields'][] = array('col_key' => 'Key');

// define contents of page footer
$structure['foot1'][] = array('type' => 'date', 'align' => 'left', 'style' => 'textalignleft');
$structure['foot1'][] = array('type' => 'pageno', 'align' => 'center');
$structure['foot1'][] = array('type' => 'time', 'align' => 'right', 'style' => 'textalignright');

$structure['foot2'][] = array('text' => 'Radicore Software Limited', 'align' => 'center');

?>