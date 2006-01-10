<?php
$structure['xsl_file'] = 'std.multi2.xsl';

$structure['tables']['outer'] = 'x_tree_type';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('tree_type_desc' => 'Tree Type');

$structure['tables']['inner'] = 'x_tree_level';

$structure['inner']['columns'][] = array('width' => 20);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 350);
$structure['inner']['columns'][] = array('width' => 250);

$structure['inner']['fields'][] = array('tree_level_id' => 'Id');
$structure['inner']['fields'][] = array('tree_level_seq' => 'Seq');
$structure['inner']['fields'][] = array('tree_level_desc' => 'Description');
$structure['inner']['fields'][] = array('blank' => '');

?>