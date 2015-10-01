<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'test_autoincrement';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => 250);
$structure['main']['columns'][] = array('width' => 250);
$structure['main']['columns'][] = array('width' => 250);

$structure['main']['fields'][] = array('option_id' => 'Id');
$structure['main']['fields'][] = array('field1' => 'Field1');
$structure['main']['fields'][] = array('field2' => 'Field2');
$structure['main']['fields'][] = array('bitwise' => 'Bitwise');

?>