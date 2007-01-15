<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'x_tree_level';

$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => 10);
$structure['outer']['columns'][] = array('width' => '*');

$structure['outer']['fields'][] = array('tree_type_desc' => 'Tree Type', 'colspan' => 2);
$structure['outer']['fields'][1][] = array('label' => 'Tree Level');
$structure['outer']['fields'][1][] = array('field' => 'tree_level_seq');
$structure['outer']['fields'][1][] = array('field' => 'tree_level_desc');

$structure['tables']['inner'] = 'x_tree_node';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 50);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 50);
$structure['inner']['columns'][] = array('width' => 120);

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('node_id' => 'Id');
$structure['inner']['fields'][] = array('node_desc' => 'Description');
$structure['inner']['fields'][] = array('node_id_snr' => 'Parent');
$structure['inner']['fields'][] = array('external_code' => 'External Code');

?>