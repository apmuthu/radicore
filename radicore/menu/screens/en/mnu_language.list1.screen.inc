<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'mnu_language';

// identify the column specs - may use 'width' or 'class'
$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 75);
$structure['main']['columns'][] = array('width' => 300);
$structure['main']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('language_id' => 'Id');
$structure['main']['fields'][] = array('language_name' => 'Name');
$structure['main']['fields'][] = array('' => '');

?>