<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'dict_table';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('database_id' => 'Database Id');
$structure['main']['fields'][] = array('table_id' => 'Table Id');
$structure['main']['fields'][] = array('subsys_dir' => 'Directory');
$structure['main']['fields'][] = array('pattern_id' => 'Pattern ID');

?>