<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'uom_conversion';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('uom_id_from' => 'FROM Unit');
$structure['main']['fields'][] = array('uom_abbrev_from' => 'Abbreviation');
$structure['main']['fields'][] = array('uom_desc_from' => 'Description');
$structure['main']['fields'][] = array('uom_id_to' => 'TO Unit');
$structure['main']['fields'][] = array('uom_abbrev_to' => 'Abbreviation');
$structure['main']['fields'][] = array('conversion_factor' => 'Conversion Factor');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>