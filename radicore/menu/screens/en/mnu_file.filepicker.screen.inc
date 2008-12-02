<?php
$structure['xsl_file'] = 'std.filepicker.list1.xsl';

$structure['tables']['main'] = 'filepicker';

// identify the number of column and their widths
$structure['main']['columns'][] = array('width' => 1);
$structure['main']['columns'][] = array('width' => '28%');
$structure['main']['columns'][] = array('width' => '5%', 'align' => 'right');
$structure['main']['columns'][] = array('width' => '17%');

// identify the field names and their screen labels
$structure['main']['fields'][] = array('selectbox' => 'S');
$structure['main']['fields'][] = array('file' => 'File Name');
$structure['main']['fields'][] = array('size' => 'Size');
$structure['main']['fields'][] = array('date' => 'File Date');

?>