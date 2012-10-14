<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'dict_relationship';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 125);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 125);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 100);

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('database_id_snr' => 'Database Id (snr)');
$structure['main']['fields'][] = array('table_id_snr' => 'Table Id (snr)');
$structure['main']['fields'][] = array('database_id_jnr' => 'Database Id (jnr)');
$structure['main']['fields'][] = array('table_id_jnr' => 'Table Id (jnr)');
$structure['main']['fields'][] = array('rel_type' => 'Constraint');

?>