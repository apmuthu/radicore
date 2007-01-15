<?php
$structure['xsl_file'] = 'std.filepicker.list1.xsl';

$structure['tables']['main'] = 'file';

$structure['main']['columns'][] = array('width' => '40%');
$structure['main']['columns'][] = array('width' => '10%');

// identify the field names and their screen labels
$structure['main']['fields'][] = array('file' => 'File Name');
$structure['main']['fields'][] = array('image' => 'Image',
                                       'imagewidth' => 75,
                                       'imageheight' => 95);

// the IMAGEWIDTH and IMAGEHEIGHT options will resize images for this display

?>