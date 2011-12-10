<?php
//*****************************************************************************
// This file contains styles to be used in PDF output
//*****************************************************************************

// column headings for LIST view
$style['hdg']['font'] = array('family' => 'Times',      // Courier, Helvetica, Times
                              'style' => 'B',           // blank=Regular, B=Bold, I=Italic, U=Underline
                              'size' => 12,             // size in points
                              'height' => 7,            // line height in units
                              'draw' => .4,             // width of drawn lines
                              'halign' => 'center');    // text alignment (left, right, center)

$style['hdg']['fillcolour'] = array(24,116,205);        // colour for background
$style['hdg']['textcolour'] = array(255,255,255);       // colour for foreground
$style['hdg']['drawcolour'] = array(128,0,0);           // colour for line drawing

// main body for LIST view
$style['body']['font'] = array('family' => 'Times',     // Courier, Helvetica, Times
                               'style' => '',           // blank=Regular, B=Bold, I=Italic, U=Underline
                               'size' => 12,            // size in points
                               'height' => 6,           // line height in units
                               'draw' => .3,            // width of drawn lines
                               'border' => 'LR');       // L=Left, R=Right, T=Top, B=Bottom, P=Page, 1=All

$style['body']['fillcolour'] = array(224,235,255);      // colour for background
$style['body']['textcolour'] = array(0,0,0);            // colour for foreground
$style['body']['drawcolour'] = array(128,0,0);          // colour for line drawing

// page title for any view
$style['title']['font'] = array('family' => 'Times',    // Courier, Helvetica, Times
                                'style' => 'B',         // blank=Regular, B=Bold, I=Italic, U=Underline
                                'size' => 12,           // size in points
                                'height' => 6,          // line height in units
                                'draw' => .3,           // width of drawn lines
                                'halign' => 'center');  // text alignment (left, right, center)

$style['title']['fillcolour'] = array(112,219,147);     // colour for background
$style['title']['textcolour'] = array(0,0,0);           // colour for foreground
$style['title']['drawcolour'] = array(0,0,0);           // colour for line drawing

$style['title1']['font'] = array('family' => 'Helvetica',    // Courier, Helvetica, Times
                                 'style' => '',          // blank=Regular, B=Bold, I=Italic, U=Underline
                                 'size' => 16,           // size in points
                                 'height' => 8,          // line height in units
                                 'draw' => .5);          // width of drawn lines

$style['title1']['fillcolour'] = array(122,103,238);     // colour for background
$style['title1']['textcolour'] = array(255,255,255);     // colour for foreground
$style['title1']['drawcolour'] = array(0,0,0);           // colour for line drawing

$style['title2']['font'] = array('family' => 'Helvetica',    // Courier, Helvetica, Times
                                 'style' => '',          // blank=Regular, B=Bold, I=Italic, U=Underline
                                 'size' => 10,           // size in points
                                 'height' => 4,          // line height in units
                                 'draw' => .2);          // width of drawn lines

$style['title2']['fillcolour'] = array(210,180,140);     // colour for background
$style['title2']['textcolour'] = array(0,0,0);           // colour for foreground
$style['title2']['drawcolour'] = array(0,0,0);           // colour for line drawing

// field labels for DETAIL view
$style['label']['font'] = array('family' => 'Times',    // Courier, Helvetica, Times
                                'style' => 'BI',        // blank=Regular, B=Bold, I=Italic, U=Underline
                                'size' => 12,           // size in points
                                'height' => 6,          // line height in units
                                'draw' => .3,           // width of drawn lines
                                'halign' => 'right');   // text alignment (left, right, center)

$style['label']['fillcolour'] = array(176,176,176);     // colour for background
$style['label']['textcolour'] = array(0,0,0);           // colour for foreground
$style['label']['drawcolour'] = array(0,0,0);           // colour for line drawing

// field data for DETAIL view
$style['data']['font'] = array('family' => 'Times',     // Courier, Helvetica, Times
                               'style' => '',           // blank=Regular, B=Bold, I=Italic, U=Underline
                               'size' => 12,            // size in points
                               'height' => 6,           // line height in units
                               'draw' => .3);           // width of drawn lines

$style['data']['fillcolour'] = false;                   // colour for background
$style['data']['textcolour'] = array(0,0,0);            // colour for foreground
$style['data']['drawcolour'] = array(0,0,0);            // colour for line drawing

// page FOOTER for all views
$style['foot']['font'] = array('family' => 'Times',     // Courier, Helvetica, Times
                               'style' => '',           // blank=Regular, B=Bold, I=Italic, U=Underline
                               'size' => 10,            // size in points
                               'height' => 5,           // line height in units
                               'draw' => 0,             // width of drawn lines
                               'halign' => 'center');   // text alignment (left, right, center)

$style['foot']['fillcolour'] = false;                   // colour for background
$style['foot']['textcolour'] = array(0,0,0);            // colour for foreground
$style['foot']['drawcolour'] = array(0,0,0);            // colour for line drawing

// allow text alignment within a cell to be changed
$style['textalignleft']['font'] = array('halign' => 'left');     // horizontal alignment = left
$style['textalignright']['font'] = array('halign' => 'right');   // horizontal alignment = right
$style['textaligncenter']['font'] = array('halign' => 'center'); // horizontal alignment = center

//$style['noborder']['drawcolour'] = array(255,255,255);        // border = white
$style['noborder']['font'] = array('draw' => 0);                // no border

// barcode styles
$style['barcode1']['drawcolour'] = array(0,0,0);        // colour for border
$style['barcode1']['draw'] = .2;                        // width of border
$style['barcode1']['type'] = 'I25';         // I25, C128A, C128B, C128C, C39, C39+, C39E, C39E+, EAN13, UPCA, POSTNET, CODABAR
$style['barcode1']['style'] = 'CDS';        // blank=default, B=Border, D=Draw Text, S=Stretch Text, N=Negative, L=Align Left, C=Align Center, R=Align Right, X=Stretch Barcode
$style['barcode1']['xres'] = 3;             // 1,2,3 (small,medium,large)
$style['barcode1']['fontsize'] = 5;         // 1,2,3,4,5 (small,small+,medium,medium+,large)
$style['barcode1']['height'] = 25;          // cell height

// barcode style showing possible manual settings
$style['barcode2']['drawcolour'] = array(0,0,0);        // colour for border
$style['barcode2']['draw'] = .2;                        // width of border
$style['barcode2']['type'] = 'I25';         // I25, C128A, C128B, C128C, C39, C39+, C39E, C39E+, EAN13, UPCA, POSTNET, CODABAR
$style['barcode2']['xres'] = 3;             // 1,2,3 (small,medium,large)
$style['barcode2']['fontsize'] = 5;         // 1,2,3,4,5 (small,small+,medium,medium+,large)
$style['barcode2']['height'] = 25;          // cell height

$style['barcode2']['font'] = 'Times';                   // font
$style['barcode2']['bgcolor'] = array(255,0,0);         // red
$style['barcode2']['fgcolor'] = array(0,0,255);         // blue
$style['barcode2']['text'] = true;
$style['barcode2']['padding'] = 2;
//$style['barcode2']['hpadding'] = 2;
//$style['barcode2']['vpadding'] = 2;
$style['barcode2']['image_border'] = true;
//$style['barcode2']['stretch'] = true;
$style['barcode2']['stretchtext'] = 4;
$style['barcode2']['align'] = 'C';
//$style['barcode2']['fitwidth'] = true;
//$style['barcode2']['cellfitalign'] = 'C';

// 2D barcode style showing possible manual settings
$style['barcode3']['drawcolour'] = array(0,0,0);        // colour for border
$style['barcode3']['draw'] = .2;                        // width of border
$style['barcode3']['type'] = 'QRCODE,L';    // QRCODE, PDF417
$style['barcode3']['height'] = 25;          // cell height

$style['barcode3']['bgcolor'] = array(255,0,0);         // red
$style['barcode3']['fgcolor'] = array(0,0,255);         // blue
$style['barcode3']['padding'] = 1;
//$style['barcode3']['hpadding'] = 2;
//$style['barcode3']['vpadding'] = 2;
$style['barcode3']['image_border'] = true;
$style['barcode3']['module_width'] = 1;
$style['barcode3']['module_height'] = 1;
$style['barcode3']['distort'] = false;

// custom styles
$style['invoice1']['font'] = array('family' => 'Helvetica', // Courier, Helvetica, Times
                               'style' => 'B',          // blank=Regular, B=Bold, I=Italic, U=Underline
                               'size' => 20,            // size in points
                               'height' => 8,           // line height in units
                               'draw' => .2,            // width of drawn lines
                               'halign' => 'right');    // text alignment (left, right, center)

$style['invoice1']['fillcolour'] = false;               // colour for background
$style['invoice1']['textcolour'] = array(0,0,0);        // colour for foreground
$style['invoice1']['drawcolour'] = array(0,0,0);        // colour for line drawing

$style['total1']['font'] = array('family' => 'Helvetica',   // Courier, Helvetica, Times
                               'style' => 'B',          // blank=Regular, B=Bold, I=Italic, U=Underline
                               'size' => 16,            // size in points
                               'height' => 8,           // line height in units
                               'draw' => .2,            // width of drawn lines
                               'halign' => 'right');    // text alignment (left, right, center)

$style['total1']['fillcolour'] = false;                 // colour for background
$style['total1']['textcolour'] = array(0,0,0);          // colour for foreground
$style['total1']['drawcolour'] = array(0,0,0);          // colour for line drawing

$style['total2']['font'] = array('family' => 'Helvetica',   // Courier, Helvetica, Times
                               'style' => '',           // blank=Regular, B=Bold, I=Italic, U=Underline
                               'size' => 9,             // size in points
                               'height' => 8,           // line height in units
                               'draw' => .2,            // width of drawn lines
                               'halign' => 'right');    // text alignment (left, right, center)

$style['total2']['fillcolour'] = false;                 // colour for background
$style['total2']['textcolour'] = array(0,0,0);          // colour for foreground
$style['total2']['drawcolour'] = array(0,0,0);          // colour for line drawing

$style['small']['font'] = array('family' => 'Helvetica', // Courier, Helvetica, Times
                                'style' => '',           // blank=Regular, B=Bold, I=Italic, U=Underline
                                'size' => 9,             // size in points
                                'height' => 6,           // line height in units
                                'draw' => .2,            // width of drawn lines
                                'halign' => 'center');   // text alignment (left, right, center)

$style['small']['fillcolour'] = false;                  // colour for background
$style['small']['textcolour'] = array(0,0,0);           // colour for foreground
$style['small']['drawcolour'] = array(0,0,0);           // colour for line drawing

$style['address']['font'] = array('family' => 'Helvetica',  // Courier, Helvetica, Times
                                  'style' => '',            // blank=Regular, B=Bold, I=Italic, U=Underline
                                  'size' => 9,              // size in points
                                  'height' => 4,            // line height in units
                                  'draw' => .2,             // width of drawn lines
                                  'halign' => 'left');      // text alignment (left, right, center)

$style['address']['fillcolour'] = false;                // colour for background
$style['address']['textcolour'] = array(0,0,0);         // colour for foreground
$style['address']['drawcolour'] = array(0,0,0);         // colour for line drawing

$style['address2']['font'] = array('family' => 'Helvetica',     // Courier, Helvetica, Times
                                 'style' => '',             // blank=Regular, B=Bold, I=Italic, U=Underline
                                 'size' => 10,              // size in points
                                 'height' => 6,             // line height in units
                                 'draw' => .2);             // width of drawn lines

$style['address2']['fillcolour'] = false;                   // colour for background
$style['address2']['textcolour'] = array(0,0,0);            // colour for foreground
$style['address2']['drawcolour'] = array(0,0,0);            // colour for line drawing

// this font is for the address labels
$style['address_labels']['font'] = array('family' => 'Helvetica',  // Courier, Helvetica, Times
                                         'style' => '',            // blank=Regular, B=Bold, I=Italic, U=Underline
                                         'size' => 9,              // size in points
                                         'height' => 4,            // line height in units
                                         'draw' => .2,             // width of drawn lines
                                         'border' => 'LRTB',       // border
                                         'halign' => 'left');      // text alignment (left, right, center)

$style['address_labels']['font']['padding_left']   = 4;
$style['address_labels']['font']['padding_top']    = 3;
//$style['address_labels']['font']['padding_right']  = 2;
$style['address_labels']['font']['padding_bottom'] = 3;

$style['address_labels']['font']['margin_bottom'] = 2;

$style['address_labels']['fillcolour'] = false;                // colour for background
$style['address_labels']['textcolour'] = array(0,0,0);         // colour for foreground
$style['address_labels']['drawcolour'] = array(0,0,0);         // colour for line drawing

$style['order_lines']['font'] = array('family' => 'Helvetica',  // Courier, Helvetica, Times
                               'style' => '',               // blank=Regular, B=Bold, I=Italic, U=Underline
                               'size' => 9,                 // size in points
                               'height' => 6,               // line height in units
                               'draw' => .2,                // width of drawn lines
                               'halign' => 'left');         // text alignment (left, right, center)

$style['order_lines']['fillcolour'] = false;                // colour for background
$style['order_lines']['textcolour'] = array(0,0,0);         // colour for foreground
$style['order_lines']['drawcolour'] = array(0,0,0);         // colour for line drawing

?>