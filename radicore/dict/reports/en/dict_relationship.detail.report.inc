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
$structure['title'][] = array('text' => '- Contents of DICT_RELATIONSHIP table -',
                              'width' => 100,
                              'align' => 'center',
                              'border' => 'y',
                              'newline' => 'y');

// set column widths
$structure['columns'][] = array('width' => 40, 'align' => 'right');
$structure['columns'][] = array('width' => 150, 'align' => 'left');

// identify labels and data to be output
$structure['body']['fields'][1][] = array('label' => 'Database Id (snr)', 'width' => 40);
$structure['body']['fields'][1][] = array('field' => 'database_id_snr', 'width' => 55);
$structure['body']['fields'][1][] = array('label' => 'Table Id (snr)', 'width' => 40);
$structure['body']['fields'][1][] = array('field' => 'table_id_snr', 'width' => 55);

$structure['body']['fields'][2][] = array('label' => 'Alias (snr)', 'width' => 135);
$structure['body']['fields'][2][] = array('field' => 'table_alias_snr', 'width' => 55);

$structure['body']['fields'][3][] = array('label' => 'Database Id (jnr)', 'width' => 40);
$structure['body']['fields'][3][] = array('field' => 'database_id_jnr', 'width' => 55);
$structure['body']['fields'][3][] = array('label' => 'Table Id (jnr)', 'width' => 40);
$structure['body']['fields'][3][] = array('field' => 'table_id_jnr', 'width' => 55);

$structure['body']['fields'][4][] = array('label' => 'Alias (jnr)', 'width' => 135);
$structure['body']['fields'][4][] = array('field' => 'table_alias_jnr', 'width' => 55);

$structure['body']['fields'][] = array('seq_no' => 'Seq Number');
$structure['body']['fields'][] = array('relation_desc' => 'Description');
$structure['body']['fields'][] = array('comment' => 'Comments');
$structure['body']['fields'][] = array('rel_type' => 'Relationship Type');
$structure['body']['fields'][] = array('orderby' => 'Order By');
$structure['body']['fields'][] = array('parent_field' => 'Parent Field');
$structure['body']['fields'][] = array('calc_field' => 'Calculated Field');

$structure['body']['fields'][35][] = array('label' => 'Created Date', 'width' => 40);
$structure['body']['fields'][35][] = array('field' => 'created_date', 'width' => 55);
$structure['body']['fields'][35][] = array('label' => 'Created By', 'width' => 40);
$structure['body']['fields'][35][] = array('field' => 'created_user', 'width' => 55);

$structure['body']['fields'][36][] = array('label' => 'Revised Date', 'width' => 40);
$structure['body']['fields'][36][] = array('field' => 'revised_date', 'width' => 55);
$structure['body']['fields'][36][] = array('label' => 'Revised By', 'width' => 40);
$structure['body']['fields'][36][] = array('field' => 'revised_user', 'width' => 55);

// label for related columns
$structure['multi1']['fields'][1][] = array('label' => 'Seq', 'width' => 10, 'align' => 'center');
$structure['multi1']['fields'][1][] = array('label' => 'Column Id (snr)', 'width' => 85, 'align' => 'center');
$structure['multi1']['fields'][1][] = array('label' => 'Column Id (jnr)', 'width' => 95, 'align' => 'center');

// data for related columns
$structure['multi2']['fields'][1][] = array('field' => 'seq_in_index', 'width' => 10, 'align' => 'center');
$structure['multi2']['fields'][1][] = array('field' => 'column_id_snr', 'width' => 85);
$structure['multi2']['fields'][1][] = array('field' => 'column_id_jnr', 'width' => 95);

// define contents of page footer
$structure['foot1'][] = array('type' => 'date', 'align' => 'left', 'style' => 'textalignleft');
$structure['foot1'][] = array('type' => 'pageno', 'align' => 'center');
$structure['foot1'][] = array('type' => 'time', 'align' => 'right', 'style' => 'textalignright');

$structure['foot2'][] = array('text' => 'Radicore Software Limited', 'align' => 'center');

?>