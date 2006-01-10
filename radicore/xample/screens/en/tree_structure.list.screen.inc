<?php
$structure['xsl_file'] = 'std.tree.list2.xsl';

$structure['tables']['outer'] = 'x_tree_type';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('tree_type_desc' => 'Tree Type');

$structure['tables']['inner'] = 'x_tree_node_jnr';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => '*');

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('node_desc' => 'Node Description', 'nosort' => 'y');

// the NOSORT keyword is optional, and will prevent the label from being a hyperlink
// which will allow the data to be sorted on that column

// identify names of important fields
$structure['inner']['node_data_names'] = array('id' => 'node_id',
                                               'desc' => 'node_desc',
                                               'depth' => 'tree_level_seq',
                                               'child_count' => 'child_count',
                                               'expanded' => 'expanded',
                                               'icon' => 'icon');
?>