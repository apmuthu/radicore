<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'x_person';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 70);
$structure['main']['columns'][] = array('width' => 100);
$structure['main']['columns'][] = array('width' => 100);
$structure['main']['columns'][] = array('width' => 100);
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('person_id' => 'Id');
$structure['main']['fields'][] = array('first_name' => 'First Name');
$structure['main']['fields'][] = array('last_name' => 'Last Name');
$structure['main']['fields'][] = array('star_sign' => 'Star Sign');
$structure['main']['fields'][] = array('pers_type_desc' => 'Person Type');

?>