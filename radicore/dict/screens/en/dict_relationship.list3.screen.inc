<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'dict_database';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('database_id' => 'Database Id (snr)');

$structure['tables']['inner'] = 'dict_relationship';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => '20%');
$structure['inner']['columns'][] = array('width' => '25%');
$structure['inner']['columns'][] = array('width' => '20%');
$structure['inner']['columns'][] = array('width' => '25%');
$structure['inner']['columns'][] = array('width' => '10%');

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('database_id_snr' => 'Database Id (snr)');
$structure['inner']['fields'][] = array('table_id_snr' => 'Table Id (snr)');
$structure['inner']['fields'][] = array('database_id_jnr' => 'Database Id (jnr)');
$structure['inner']['fields'][] = array('table_id_jnr' => 'Table Id (jnr)');
$structure['inner']['fields'][] = array('rel_type' => 'Constraint');

?>