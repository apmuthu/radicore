<?php
$structure['xsl_file'] = 'std.filepicker.list1.xsl';

$structure['tables']['main'] = 'file';

$structure['main']['columns'][] = array('width' => '40%', 'nosort' => 'y');
$structure['main']['columns'][] = array('width' => '10%', 'nosort' => 'y');

// identify the field names and their screen labels
$structure['main']['fields'][] = array('file' => 'File Name', 'nosort' => 'y');
$structure['main']['fields'][] = array('image' => 'Image', 'nosort' => 'y',
                                       'imagewidth' => 75,
                                       'imageheight' => 95);

// the NOSORT keyword is optional, and will prevent the label from being a hyperlink
// which will allow the data to be sorted on that column

// the IMAGEWIDTH and IMAGEHEIGHT options will resize images for this display

?>