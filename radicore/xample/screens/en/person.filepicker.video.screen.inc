<?php
$structure['xsl_file'] = 'std.filepicker.list1.xsl';

$structure['tables']['main'] = 'file';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('file' => 'File Name');
$structure['main']['fields'][] = array('video' => 'Video',
                                       'imageheight' => 180,
                                       'imagewidth' => 320,
                                       'nosort' => 'y');

?>