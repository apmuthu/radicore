<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = '#tablename#';

// identify the column specs - may use 'width' or 'class'
$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => 100);
$structure['main']['columns'][] = array('width' => '*');

// the contents of this screen are constructed at run time

?>