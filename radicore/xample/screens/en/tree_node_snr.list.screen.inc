<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'x_tree_node';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('tree_type_desc' => 'Tree Type');
$structure['outer']['fields'][] = array('tree_level_desc' => 'Tree Level');
$structure['outer']['fields'][] = array('node_desc' => 'Description');

$structure['tables']['inner'] = 'x_tree_node_snr';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 10);
$structure['inner']['columns'][] = array('width' => 150);
$structure['inner']['columns'][] = array('width' => 10);
$structure['inner']['columns'][] = array('width' => 200);
$structure['inner']['columns'][] = array('width' => 120);

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('tree_level_seq' => 'Level', 'nosort' => 'y');
$structure['inner']['fields'][] = array('tree_level_desc' => 'Level Description', 'nosort' => 'y');
$structure['inner']['fields'][] = array('node_id' => 'Node', 'nosort' => 'y');
$structure['inner']['fields'][] = array('node_desc' => 'Node Description', 'nosort' => 'y');
$structure['inner']['fields'][] = array('external_code' => 'External Code', 'nosort' => 'y');

?>