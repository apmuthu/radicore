<?php
$structure['xsl_file'] = 'std.tree.list1.xsl';

$structure['tables']['main'] = '#tablename#';

// identify the column specs - may use 'width' or 'class'
$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 350);

// identify the field names and their screen labels
$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('node_desc' => 'Node Description', 'nosort' => 'y');

// identify names of important fields
$structure['main']['node_data_names'] = array('id' => 'node_id',
                                              'desc' => 'node_desc',
                                              'depth' => 'node_depth',
                                              'child_count' => 'child_count',
                                              'expanded' => 'expanded',
                                              'icon' => 'icon');

?>