<?php
// report structure for a LIST view

$structure['pdf'] = array('orientation' => 'L',     // L=Landscape, P=Portrait
                          'units' => 'mm',          // pt=Point, mm=Millimeter, cm=Centimeter, in=Inch
                          'format' => 'A4',         // A3, A4, A5, Letter, Legal
                          'name' => '',             // filename (if destination = D or F)
                          'destination' => 'I');    // I=Inline (browser), D=Download (browser), F=Filename (on server), S=String

$structure['title']['style'] = 'title';             // style for page title
$structure['head']['style']  = 'hdg';               // style for column heading
$structure['body']['style']  = 'body';              // style for main body
$structure['foot']['style']  = 'foot';              // style for page footer

// define contents of page title
$structure['title'][] = array('text' => "- Contents of DICT_RELATIONSHIP table -",
                              'width' => 100,
                              'align' => 'center',
                              'border' => 'y');

// set column widths
$structure['columns'][] = array('width' => 30);
$structure['columns'][] = array('width' => 44, 'overflow' => 'y');
$structure['columns'][] = array('width' => 44, 'overflow' => 'y');
$structure['columns'][] = array('width' => 30);
$structure['columns'][] = array('width' => 44, 'overflow' => 'y');
$structure['columns'][] = array('width' => 44, 'overflow' => 'y');
$structure['columns'][] = array('width' => 10, 'align' => 'center');
$structure['columns'][] = array('width' => 30);

// identify column names and associated labels
$structure['body']['fields'][] = array('database_id_snr' => 'Database (Snr)');
$structure['body']['fields'][] = array('table_id_snr' => 'Table (Snr)');
$structure['body']['fields'][] = array('table_alias_snr' => 'Alias (Snr)');
$structure['body']['fields'][] = array('database_id_jnr' => 'Database (Jnr)');
$structure['body']['fields'][] = array('table_id_jnr' => 'Table (Jnr)');
$structure['body']['fields'][] = array('table_alias_jnr' => 'Alias (Jnr)');
$structure['body']['fields'][] = array('seq_no' => 'Seq');
$structure['body']['fields'][] = array('rel_type' => 'Type');

// define contents of page footer
$structure['foot1'][] = array('type' => 'date', 'align' => 'left', 'style' => 'textalignleft');
$structure['foot1'][] = array('type' => 'pageno', 'align' => 'center');
$structure['foot1'][] = array('type' => 'time', 'align' => 'right', 'style' => 'textalignright');

$structure['foot2'][] = array('text' => 'Radicore Software Limited', 'align' => 'center');

?>