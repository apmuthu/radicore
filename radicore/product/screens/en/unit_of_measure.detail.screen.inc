<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'unit_of_measure';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('uom_id' => 'UOM Id');
$structure['main']['fields'][] = array('uom_cat_id' => 'Category');
$structure['main']['fields'][] = array('uom_abbrev' => 'Abbreviation');
$structure['main']['fields'][] = array('uom_desc' => 'Description');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>