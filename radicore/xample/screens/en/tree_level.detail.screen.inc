<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'x_tree_level';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '75%');

$structure['main']['fields'][] = array('tree_type_desc' => 'Tree Type');
$structure['main']['fields'][] = array('tree_level_id' => 'Tree Level Id');
$structure['main']['fields'][] = array('tree_level_seq' => 'Tree Level Seq');
$structure['main']['fields'][] = array('tree_level_desc' => 'Description');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>