<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'x_tree_node';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '75%');

$structure['main']['fields'][] = array('tree_type_desc' => 'Tree Type');
$structure['main']['fields'][] = array('tree_level_desc' => 'Tree Level');
$structure['main']['fields'][] = array('node_id' => 'Node Id');
$structure['main']['fields'][] = array('node_desc' => 'Description');
$structure['main']['fields'][] = array('external_code' => 'External Code');
$structure['main']['fields'][] = array('node_id_snr' => 'Parent Node');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>