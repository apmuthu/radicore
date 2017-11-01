<?php
$structure['xsl_file'] = 'std.filepicker.list1.xsl';

$structure['tables']['main'] = 'filepicker';

// identify the number of column and their widths
$structure['main']['columns'][] = array('width' => '40%');
//$structure['main']['columns'][] = array('width' => '5%');
//$structure['main']['columns'][] = array('width' => '10%');
$structure['main']['columns'][] = array('width' => '10%');

// identify the field names and their screen labels
$structure['main']['fields'][] = array('file' => 'File Name');
//$structure['main']['fields'][] = array('size' => 'Size');
//$structure['main']['fields'][] = array('date' => 'File Date');
$structure['main']['fields'][] = array('image' => 'Image',
                                       'imagewidth' => 75,
                                       'imageheight' => 95,
                                       'nosort' => 'y');

// the IMAGEWIDTH and IMAGEHEIGHT options will resize images for this display

?>