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
                              'halign' => 'center');    // horizontal text alignment (left, right, center)

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

$style['title1']['font'] = array('family' => 'Helvetica',// Courier, Helvetica, Times
                                 'style' => '',          // blank=Regular, B=Bold, I=Italic, U=Underline
                                 'size' => 16,           // size in points
                                 'height' => 8,          // line height in units
                                 'draw' => .5);          // width of drawn lines

$style['title1']['fillcolour'] = array(122,103,238);     // colour for background
$style['title1']['textcolour'] = array(255,255,255);     // colour for foreground
$style['title1']['drawcolour'] = array(0,0,0);           // colour for line drawing

$style['title2']['font'] = array('family' => 'Helvetica',// Courier, Helvetica, Times
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
                                'halign' => 'right');   // horizontal text alignment (left, right, center)

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
                               'draw' => 0,             // width of drawn lines
                               'halign' => 'center');   // horizontal text alignment (left, right, center)

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
$style['barcode1']['font']['draw'] = .2;                // width of border
$style['barcode1']['type'] = 'I25';         // I25, C128A, C128B, C128C, C39
$style['barcode1']['style'] = 'CDS';        // blank=default, B=Border, D=Draw Text, S=Stretch Text, N=Negative, L=Align Left, C=Align Center, R=Align Right, X=Stretch Barcode
$style['barcode1']['xres'] = 2;             // 1,2,3
$style['barcode1']['fontsize'] = 5;         // 1,2,3,4,5

?>