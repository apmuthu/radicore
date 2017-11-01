<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_file';

// identify the column specs - may use 'width' or 'class'
$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '*');

// identify the contents of each row in the table (two formats are allowed)
// the SHORT format defines two cells per row, a label followed by a field, as in:
$structure['main']['fields'][] = array('filename' => 'File Name');


?>