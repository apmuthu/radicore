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
                              'halign' => 'center',     // horizontal text alignment (left, right, center)
                              'valign' => 'middle');    // vertical text alignment (top, middle, bottom)

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
                                'halign' => 'center');  // horizontal text alignment (left, right, center)

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
                                'halign' => 'right');   // hoizontal text alignment (left, right, center)

$style['label']['fillcolour'] = array(176,176,176);     // colour for background
$style['label']['textcolour'] = array(0,0,0);           // colour for foreground
$style['label']['drawcolour'] = array(0,0,0);           // colour for line drawing

// field data for DETAIL view
$style['data']['font'] = array('family' => 'Times',     // Courier, Helvetica, Times
                               'style' => '',           // blank=Regular, B=Bold, I=Italic, U=Underline
                               'size' => 12,            // size in points
                               'height' => 6,           // line height in units
                               'draw' => .3);           // width of drawn lines

$style['data']['fillcolour'] = array(255,255,255);      // colour for background
$style['data']['textcolour'] = array(0,0,0);            // colour for foreground
$style['data']['drawcolour'] = array(0,0,0);            // colour for line drawing

// page FOOTER for all views
$style['foot']['font'] = array('family' => 'Times',     // Courier, Helvetica, Times
                               'style' => '',           // blank=Regular, B=Bold, I=Italic, U=Underline
                               'size' => 10,            // size in points
                               'height' => 5,           // line height in units
                               'draw' => .2,            // width of drawn lines
                               'halign' => 'center');   // horizontal text alignment (left, right, center)

$style['foot']['fillcolour'] = array(255,255,255);      // colour for background
$style['foot']['textcolour'] = array(0,0,0);            // colour for foreground
$style['foot']['drawcolour'] = array(0,0,0);            // colour for line drawing

// allow text alignment within a cell to be changed
$style['textalignleft']['font'] = array('halign' => 'left');     // text alignment = left
$style['textalignright']['font'] = array('halign' => 'right');   // text alignment = right
$style['textaligncenter']['font'] = array('halign' => 'center'); // text alignment = center
$style['noborder']['drawcolour'] = array(255,255,255);           // border = white

// barcode styles
$style['barcode1']['type'] = 'I25';         // I25, C128A, C128B, C128C, C39, C39+, C39E, C39E+, EAN13, UPCA, POSTNET, CODABAR
$style['barcode1']['style'] = 'CDS';        // blank=default, B=Border, D=Draw Text, S=Stretch Text, N=Negative, L=Align Left, C=Align Center, R=Align Right, X=Stretch Barcode
$style['barcode1']['xres'] = 3;             // 1,2,3 (small,medium,large)
$style['barcode1']['fontsize'] = 5;         // 1,2,3,4,5 (small,small+,medium,medium+,large)
//$style['barcode1']['bgcolor'] = array(255,0,0);     // red
//$style['barcode1']['fgcolor'] = array(0,0,255);     // blue
//$style['barcode1']['xres'] = 0.4;
//$style['barcode1']['padding'] = 1;
//$style['barcode1']['border'] = true;
//$style['barcode1']['text'] = true;
//$style['barcode1']['position'] = 'S';
//$style['barcode1']['stretchtext'] = 4;
//$style['barcode1']['font'] = 'Helvetica';
//$style['barcode1']['fontsize'] = 10;
//$style['barcode1']['fontstyle'] = 'BI';

// custom styles
$style['invoice1']['font'] = array('family' => 'Helvetica', // Courier, Helvetica, Times
                               'style' => 'B',          // blank=Regular, B=Bold, I=Italic, U=Underline
                               'size' => 20,            // size in points
                               'height' => 8,           // line height in units
                               'draw' => .2,            // width of drawn lines
                               'align' => 'right');     // text alignment (left, right, center)

$style['invoice1']['fillcolour'] = array(255,255,255);  // colour for background
$style['invoice1']['textcolour'] = array(0,0,0);        // colour for foreground
$style['invoice1']['drawcolour'] = array(0,0,0);        // colour for line drawing

$style['total1']['font'] = array('family' => 'Helvetica',   // Courier, Helvetica, Times
                               'style' => 'B',          // blank=Regular, B=Bold, I=Italic, U=Underline
                               'size' => 16,            // size in points
                               'height' => 8,           // line height in units
                               'draw' => .2,            // width of drawn lines
                               'align' => 'right');     // text alignment (left, right, center)

$style['total1']['fillcolour'] = array(255,255,255);    // colour for background
$style['total1']['textcolour'] = array(0,0,0);          // colour for foreground
$style['total1']['drawcolour'] = array(0,0,0);          // colour for line drawing

$style['total2']['font'] = array('family' => 'Helvetica',   // Courier, Helvetica, Times
                               'style' => '',           // blank=Regular, B=Bold, I=Italic, U=Underline
                               'size' => 9,             // size in points
                               'height' => 8,           // line height in units
                               'draw' => .2,            // width of drawn lines
                               'align' => 'right');     // text alignment (left, right, center)

$style['total2']['fillcolour'] = array(255,255,255);    // colour for background
$style['total2']['textcolour'] = array(0,0,0);          // colour for foreground
$style['total2']['drawcolour'] = array(0,0,0);          // colour for line drawing

$style['small']['font'] = array('family' => 'Helvetica',    // Courier, Helvetica, Times
                               'style' => '',           // blank=Regular, B=Bold, I=Italic, U=Underline
                               'size' => 9,             // size in points
                               'height' => 6,           // line height in units
                               'draw' => .2,            // width of drawn lines
                               //'valign' => 'top',       // vertical alignment (top, middle, bottom)
                               'align' => 'center');    // text alignment (left, right, center)

$style['small']['fillcolour'] = array(255,255,255);     // colour for background
$style['small']['textcolour'] = array(0,0,0);           // colour for foreground
$style['small']['drawcolour'] = array(0,0,0);           // colour for line drawing

$style['address']['font'] = array('family' => 'Helvetica',  // Courier, Helvetica, Times
                               'style' => '',           // blank=Regular, B=Bold, I=Italic, U=Underline
                               'size' => 9,             // size in points
                               'height' => 4,           // line height in units
                               'draw' => .2,            // width of drawn lines
                               'align' => 'left');      // text alignment (left, right, center)

$style['address']['fillcolour'] = array(255,255,255);   // colour for background
$style['address']['textcolour'] = array(0,0,0);         // colour for foreground
$style['address']['drawcolour'] = array(0,0,0);         // colour for line drawing

$style['address2']['font'] = array('family' => 'Helvetica',     // Courier, Helvetica, Times
                                 'style' => '',             // blank=Regular, B=Bold, I=Italic, U=Underline
                                 'size' => 10,              // size in points
                                 'height' => 6,             // line height in units
                                 'draw' => .2);             // width of drawn lines

$style['address2']['fillcolour'] = array(255,255,255);      // colour for background
$style['address2']['textcolour'] = array(0,0,0);            // colour for foreground
$style['address2']['drawcolour'] = array(0,0,0);            // colour for line drawing


$style['order_lines']['font'] = array('family' => 'Helvetica',  // Courier, Helvetica, Times
                               'style' => '',               // blank=Regular, B=Bold, I=Italic, U=Underline
                               'size' => 9,                 // size in points
                               'height' => 6,               // line height in units
                               'draw' => .2,                // width of drawn lines
                               'align' => 'left');          // text alignment (left, right, center)

$style['order_lines']['fillcolour'] = array(255,255,255);   // colour for background
$style['order_lines']['textcolour'] = array(0,0,0);         // colour for foreground
$style['order_lines']['drawcolour'] = array(0,0,0);         // colour for line drawing

// alternative colours
$style['red']['textcolour'] = array(255,0,0);            // colour for foreground
$style['green']['textcolour'] = array(0,255,0);          // colour for foreground
$style['blue']['textcolour'] = array(0,0,255);           // colour for foreground

?>