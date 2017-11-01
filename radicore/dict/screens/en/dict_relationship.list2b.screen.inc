<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'dict_table_jnr';

$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '18%');
$structure['outer']['columns'][] = array('width' => '*');

$structure['outer']['fields'][1][] = array('label' => 'Database Id (jnr)');
$structure['outer']['fields'][1][] = array('field' => 'database_id');
$structure['outer']['fields'][1][] = array('label' => 'Table Id (jnr)');
$structure['outer']['fields'][1][] = array('field' => 'table_id');

$structure['tables']['inner'] = 'dict_relationship_snr';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 175);

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('database_id_snr' => 'Database Id (snr)');
$structure['inner']['fields'][] = array('table_id_snr' => 'Table Id (snr)');
$structure['inner']['fields'][] = array('relation_type' => 'Constraint');

?>