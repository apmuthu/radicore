<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'x_tree_node_snr';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('tree_type_desc' => 'Tree Type');
$structure['outer']['fields'][] = array('tree_level_desc' => 'Tree Level');
$structure['outer']['fields'][] = array('node_desc' => 'Parent Node');

$structure['tables']['inner'] = 'x_tree_node_jnr';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 50);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 10);
$structure['inner']['columns'][] = array('width' => 150);

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('node_id' => 'Id');
$structure['inner']['fields'][] = array('node_desc' => 'Description');
$structure['inner']['fields'][] = array('node_id_snr' => 'Parent');
$structure['inner']['fields'][] = array('external_code' => 'External Code');

?>