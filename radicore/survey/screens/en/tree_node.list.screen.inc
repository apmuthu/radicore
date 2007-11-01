<?php
$structure['xsl_file'] = 'std.tree.list1.xsl';

$structure['tables']['main'] = 'tree_node';

$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('node_desc' => 'Node Description', 'nosort' => 'y');

$structure['main']['node_data_names'] = array('id' => 'node_id',
                                              'desc' => 'node_desc',
                                              'depth' => 'node_depth',
                                              'child_count' => 'child_count',
                                              'expanded' => 'expanded',
                                              'icon' => 'icon');

?>