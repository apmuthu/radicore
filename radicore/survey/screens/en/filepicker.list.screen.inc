<?php
$structure['xsl_file'] = 'std.filepicker.list1.xsl';

$structure['tables']['main'] = 'file';

$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 16);

$structure['main']['fields'][] = array('file' => 'File Name');
$structure['main']['fields'][] = array('icon' => 'Icon',
                                       'imagewidth' => 16,
                                       'imageheight' => 16);

?>