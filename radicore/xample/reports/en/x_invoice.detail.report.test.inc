<?php
$structure['pdf'] = array('orientation' => 'P',     // L=Landscape, P=Portrait
                          'units' => 'mm',          // pt=Point, mm=Millimeter, cm=Centimeter, in=Inch
                          'format' => 'A4',         // A3, A4, A5, Letter, Legal
                          'name' => '',             // filename (if destination = D or F)
                          'destination' => 'I');    // I=Inline (browser), D=Download (browser), F=Filename (on server), S=String

$structure['title']['style'] = 'address2';          // style for page heading
$structure['label']['style'] = 'order_lines';       // style for field labels
$structure['data']['style']  = 'order_lines';       // style for field data
$structure['foot']['style']  = 'foot';              // style for page footer

// define contents of page title

$structure['title'][] = array('image' => 'images/radicore.jpg',
                              //'padding_top' => 1,
                              //'padding_bottom' => 1,
                              //'padding_left' => 1,
                              //'padding_right' => 1,
                              //'image_border' => 'y',
                              //'border' => 'y',
                              'imagewidth' => 84,
                              'imageheight' => 45);

$structure['title'][] = array('text' => "%%company_name",
                              'width' => 60,
                              'style' => 'address2',
                              'align' => 'left',
                              'marginleft' => 34.5);

$structure['title'][] = array('text' => "%%company_address",
                              'width' => 60,
                              'style' => 'address2',
                              'align' => 'left',
                              'marginleft' => 34.5,
                              'x' => 95.5,
                              'y' => 5);

// this identifies the document type
$structure['title'][] = array('text' => "Invoice",
                              'width' => 30,
                              'align' => 'right',
                              'style' => 'invoice1',
                              'y' => 1,
                              'newline' => 'y');

// cell headings
$structure['title'][] = array('text' => 'VAT Registration No.',
                              'width' => 40,
                              'style' => 'small',
                              'x' => 95.5,
                              'y' => 14,
                              'border' => 'y');

$structure['title'][] = array('text' => 'TAX DATE',
                              'width' => 25,
                              'style' => 'small',
                              'border' => 'y');

$structure['title'][] = array('text' => 'INVOICE NO.',
                              'width' => 29.5,
                              'style' => 'small',
                              'border' => 'y',
                              'newline' => 'y');

// cell contents
$structure['title'][] = array('text' => '123 4567 89',
                              'width' => 40,
                              'style' => 'small',
                              'x' => 95.5,
                              'border' => 'y');

$structure['title'][] = array('text' => '%%invoice_date',
                              'width' => 25,
                              'style' => 'small',
                              'border' => 'y');

$structure['title'][] = array('text' => '%%invoice_no',
                              'width' => 29.5,
                              'style' => 'small',
                              'border' => 'y',
                              'newline' => 'y');

// start new line for INVOICE and SHIPPING addresses
$structure['title'][] = array('text' => 'INVOICE TO:',
                              'width' => 94.5,
                              'y_relative' => 1,
                              'border' => 'y',
                              'align' => 'left');

$structure['title'][] = array('text' => 'SHIP TO:',
                              'width' => 94.5,
                              'border' => 'y',
                              'align' => 'right',
                              //'style' => 'textaligncenter',
                              'newline' => 'y');

// supply text for INVOICE_TO and SHIP_TO
$structure['title'][] = array('text' => '%%invoice_to',
                              'width' => 92,
                              'style' => 'address',
                              'x' => 2,
                              'y_relative' => 1);

$structure['title'][] = array('text' => '%%ship_to',
                              'width' => 92,
                              'style' => 'address',
                              'marginleft' => 3.5);

// paint empty boxes for INVOICE_TO and SHIP_TO
$structure['title'][] = array('text' => '',
                              'nofill' => 'y',
                              'width' => 94.5,
                              'height' => 34,
                              'border' => 'y',
                              'align' => 'left',
                              'y_relative' => -1);

$structure['title'][] = array('text' => '',
                              'nofill' => 'y',
                              'width' => 94.5,
                              'height' => 34,
                              'border' => 'y',
                              'align' => 'r1ght',
                              'newline' => 'y');

// box for delivery address (not printed if empty)
$structure['title'][] = array('text' => '%%delivery_address',
                              'width' => 190,
                              'height' => 8,
                              'y_relative' => 1,
                              'border' => 'y',
                              'ignore_if_empty' => 'y',
                              'newline' => 'y');

// start first heading line
$structure['title'][] = array('text' => 'P.O. NUMBER',
                              'width' => 30,
                              'style' => 'textaligncenter',
                              'y_relative' => 1,
                              'border' => 'y');

$structure['title'][] = array('text' => 'TERMS',
                              'width' => 32,
                              'marginleft' => 1,
                              'style' => 'textaligncenter',
                              'border' => 'y');

$structure['title'][] = array('text' => 'SHIP DATE',
                              'width' => 30.5,
                              'marginleft' => 1,
                              'style' => 'textaligncenter',
                              'border' => 'y');

$structure['title'][] = array('text' => 'CARRIER',
                              'width' => 46.5,
                              'marginleft' => 1,
                              'style' => 'textaligncenter',
                              'border' => 'y');

$structure['title'][] = array('text' => 'CUSTOMER CONTACT',
                              'width' => 47,
                              'marginleft' => 1,
                              'style' => 'textaligncenter',
                              'border' => 'y',
                              'newline' => 'y');

// fill in details below first heading line
$structure['title'][] = array('text' => '%%purchase_order_id',
                              'width' => 30,
                              'style' => 'textaligncenter',
                              'border' => 'y');

$structure['title'][] = array('text' => '%%payment_terms',
                              'width' => 32,
                              'marginleft' => 1,
                              'style' => 'textaligncenter',
                              'border' => 'y');

$structure['title'][] = array('text' => '%%ship_date',
                              'width' => 30.5,
                              'marginleft' => 1,
                              'style' => 'textaligncenter',
                              'border' => 'y');

$structure['title'][] = array('text' => '%%carrier_id',
                              'width' => 46.5,
                              'marginleft' => 1,
                              'style' => 'textaligncenter',
                              'border' => 'y');

$structure['title'][] = array('text' => '%%cust_contact',
                              'width' => 47,
                              'marginleft' => 1,
                              'style' => 'textaligncenter',
                              'border' => 'y',
                              'newline' => 'y');

// sample barcode
$structure['title'][] = array('text' => 'Barcode->',
                              'width' => 20,
                              'height' => 10,
                              'style' => 'textaligncenter',
                              'y_relative' => 1,
                              'border' => 'y');

$structure['title'][] = array('barcode' => '%%barcode',
                              'barcode_style' => 'barcode1',
                              'width' => 80,
                              'height' => 25,
                              'border' => 'y',
                              'image_offset' => .5,
                              'image_border' => 'y');

$structure['title'][] = array('text' => '<-Barcode',
                              'width' => 20,
                              'style' => 'textaligncenter',
                              'border' => 'y',
                              'newline' => 'y');

// start second heading line
$structure['title'][] = array('text' => 'QUANTITY',
                              'width' => 20,
                              'height' => 8,
                              'style' => 'textaligncenter',
                              'y_relative' => 1,
                              'border' => 'y');

$structure['title'][] = array('text' => 'ITEM',
                              'width' => 30,
                              'height' => 8,
                              'style' => 'textaligncenter',
                              'border' => 'y');

$structure['title'][] = array('text' => 'DESCRIPTION',
                              'width' => 75,
                              'height' => 8,
                              'style' => 'textaligncenter',
                              'border' => 'y');

$structure['title'][] = array('text' => 'PRICE',
                              'width' => 25,
                              'height' => 8,
                              'style' => 'textaligncenter',
                              'border' => 'y');

$structure['title'][] = array('text' => 'AMOUNT',
                              'width' => 25,
                              'height' => 8,
                              'style' => 'textaligncenter',
                              'border' => 'y');

$structure['title'][] = array('text' => 'VAT%',
                              'width' => 15,
                              'height' => 8,
                              'style' => 'textaligncenter',
                              'border' => 'y');

// identify output for 1st additional zone
$structure['multi1']['fields'][1][] = array('field' => 'quantity', 'width' => 20, 'halign' => 'center', 'y_relative' => 1);
$structure['multi1']['fields'][1][] = array('field' => 'product_name', 'width' => 30);
$structure['multi1']['fields'][1][] = array('field' => 'product_desc', 'width' => 75);
//$structure['multi1']['fields'][1][] = array('field' => 'picture', 'width' => 75, 'notext' => 'y');

$structure['multi1']['fields'][1][] = array('field' => 'product_price', 'width' => 25, 'halign' => 'right');
$structure['multi1']['fields'][1][] = array('field' => 'extended_price', 'width' => 25, 'halign' => 'right');
$structure['multi1']['fields'][1][] = array('field' => 'vat_percent', 'width' => 15, 'halign' => 'center');

// additional lines to demonstrate 'ignore_if_empty' option
$structure['multi1']['fields'][2][] = array('field' => 'image_label',
                                            'width' => '20',
                                            'style' => 'noborder',
                                            'y_relative' => 1,
                                            'valign' => 'T',
                                            'ignore_if_empty' => 'y');

$structure['multi1']['fields'][2][] = array('image' => '%%image_01',
                                            'imagewidth' => 75,
                                            'imageheight' => 95,
                                            //'width' => 40,
                                            //'height' => 20,
                                            'style' => 'noborder',
                                            //'padding_top' => 1,
                                            //'padding_bottom' => 1,
                                            //'padding_left' => 1,
                                            //'padding_right' => 1,
                                            //'image_border' => 'y',
                                            'ignore_if_empty' => 'y');

$structure['multi1']['fields'][2][] = array('image' => '%%image_02',
                                            'imagewidth' => 75,
                                            'imageheight' => 95,
                                            //'width' => 40,
                                            //'height' => 20,
                                            'style' => 'noborder',
                                            //'padding_top' => 1,
                                            //'padding_bottom' => 1,
                                            //'padding_left' => 1,
                                            //'padding_right' => 1,
                                            //'image_border' => 'y',
                                            'ignore_if_empty' => 'y');

$structure['multi1']['fields'][3][] = array('text' => '',
                                            'width' => '100%',
                                            'style' => 'rule',
                                            //'newline' => 'y',
                                            'y_relative' => 1);

$structure['multi10']['fields'][1][] = array('image' => '%%multi10_image',
                                             'imagewidth' => 84,
                                             'imageheight' => 45,
                                             //'width' => 40,
                                             //'height' => 20,
                                             'x' => 20,
                                             'y_relative' => 1,
                                             //'style' => 'noborder',
                                             //'padding_top' => 1,
                                             //'padding_bottom' => 1,
                                             //'padding_left' => 1,
                                             //'padding_right' => 1,
                                             //'image_border' => 'y',
                                             'ignore_if_empty' => 'y');

$structure['multi10']['fields'][1][] = array('field' => 'multi10_text',
                                             'width' => 30,
                                             'height' => 20,
                                             'style' => 'textaligncenter',
                                             //'border' => 'y',
                                             'ignore_if_empty' => 'y');

// identify output for 2nd additional zone
//$structure['multi2']['fields'][1][] = array('label' => '', 'width' => 20);
//$structure['multi2']['fields'][1][] = array('field' => 'note_id',
//                                            'width' => 30,
//                                            'marginleft' => 20);
//$structure['multi2']['fields'][1][] = array('field' => 'note_text',
//                                            'width' => 75);
//$structure['multi2']['fields'][1][] = array('label' => '', 'width' => 25);
//$structure['multi2']['fields'][1][] = array('label' => '', 'width' => 25);
//$structure['multi2']['fields'][1][] = array('label' => '', 'width' => 15);

$structure['multi9']['fields'][1][] = array('field' => 'multi9_1', 'width' => '50%', 'ignore_if_empty' => 'y');
$structure['multi9']['fields'][1][] = array('field' => 'multi9_2', 'width' => '50%', 'ignore_if_empty' => 'y');

// identify output for 3rd additional zone (3 lines)
$structure['multi3']['fields'][1][] = array('label' => 'VAT%',
                                            'width' => 30,
                                            'style' => 'total2',
                                            'halign' => 'center',
                                            'y_minimum' => 225,
                                            'y' => 225);
$structure['multi3']['fields'][1][] = array('label' => 'VAT AMOUNT',
                                            'width' => 32.5,
                                            'style' => 'total2',
                                            'halign' => 'center');
$structure['multi3']['fields'][1][] = array('label' => 'VAT%',
                                            'width' => 30,
                                            'style' => 'total2',
                                            'halign' => 'center');
$structure['multi3']['fields'][1][] = array('label' => 'VAT AMOUNT',
                                            'width' => 32.5,
                                            'style' => 'total2',
                                            'halign' => 'center');
$structure['multi3']['fields'][1][] = array('label' => 'SUB TOTAL',
                                            'width' => 35,
                                            'style' => 'total2');
$structure['multi3']['fields'][1][] = array('field' => 'sub_total',
                                            'width' => 30,
                                            'style' => 'total2');

$structure['multi3']['fields'][2][] = array('field' => 'vat_percent1',
                                            'width' => 30,
                                            'style' => 'total2',
                                            'halign' => 'center');
$structure['multi3']['fields'][2][] = array('field' => 'vat_amount1',
                                            'width' => 32.5,
                                            'style' => 'total2',
                                            'halign' => 'center');
$structure['multi3']['fields'][2][] = array('field' => 'vat_percent2',
                                            'width' => 30,
                                            'style' => 'total2',
                                            'halign' => 'center');
$structure['multi3']['fields'][2][] = array('field' => 'vat_amount2',
                                            'width' => 32.5,
                                            'style' => 'total2',
                                            'halign' => 'center');
$structure['multi3']['fields'][2][] = array('label' => 'VAT TOTAL',
                                            'width' => 35,
                                            'style' => 'total2');
$structure['multi3']['fields'][2][] = array('field' => 'vat_total',
                                            'width' => 30,
                                            'style' => 'total2');

$structure['multi3']['fields'][3][] = array('label' => 'Thank you for your order',
                                            'width' => 125,
                                            'style' => 'total2',
                                            'halign' => 'left');
$structure['multi3']['fields'][3][] = array('label' => 'TOTAL    ',
                                            'width' => 35,
                                            'style' => 'total1');
$structure['multi3']['fields'][3][] = array('field' => 'inv_total',
                                            'width' => 30,
                                            'style' => 'total2');

// identify output for 4th additional zone (2 lines)
//$structure['multi4']['fields'][1][] = array('label' => 'Phone #', 'width' => 40, 'halign' => 'center', 'height' => 8, 'y_relative' => 1);
//$structure['multi4']['fields'][1][] = array('label' => 'Fax #', 'width' => 40, 'halign' => 'center', 'height' => 8);
//$structure['multi4']['fields'][1][] = array('barcode' => 'barcode', 'barcode_style' => 'barcode1', 'width' => 80, 'height' => 25);
//$structure['multi4']['fields'][2][] = array('label' => '+44 (0) 1234 222222', 'width' => 40, 'halign' => 'center', 'height' => 8);
//$structure['multi4']['fields'][2][] = array('label' => '+44 (0) 1234 222223', 'width' => 40, 'halign' => 'center', 'height' => 8);

$structure['multi4']['fields'][1][] = array('label' => 'Phone #',
                                            'width' => 40,
                                            'height' => 9,
                                            'halign' => 'center',
                                            'y_relative' => 1);
$structure['multi4']['fields'][1][] = array('barcode' => 'barcode',
                                            'barcode_style' => 'barcode1',
                                            'width' => 80,
                                            'height' => 25,
                                            'border' => 'y');
$structure['multi4']['fields'][1][] = array('label' => 'Fax #',
                                            'width' => 40,
                                            'height' => 9,
                                            'halign' => 'center');
$structure['multi4']['fields'][2][] = array('label' => '+44 (0) 1234 222222',
                                            'width' => 40,
                                            'height' => 9,
                                            'halign' => 'center',
                                            'y_relative' => -16);
$structure['multi4']['fields'][2][] = array('label' => '+44 (0) 1234 222223',
                                            'width' => 40,
                                            'height' => 9,
                                            'halign' => 'center',
                                            'marginleft' => 80);

// define contents of page footer
//$structure['foot1'][] = array('type' => 'date', 'align' => 'left', 'style' => 'textalignleft');
$structure['foot1'][] = array('type' => 'pageno', 'align' => 'center', 'margin_left' => 8.5);
//$structure['foot1'][] = array('type' => 'time', 'align' => 'right', 'style' => 'textalignright');
$structure['foot2'][] = array('text' => '%%company_name', 'align' => 'center');

?>