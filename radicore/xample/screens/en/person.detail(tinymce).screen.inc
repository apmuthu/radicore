<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'x_person';

$structure['main']['columns'][] = array('width' => '10%');
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('person_id' => 'Id');

$structure['main']['fields'][] = array('fckeditor_test' => 'TinyMCE');

?>