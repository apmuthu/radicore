<?php
$structure['xsl_file'] = 'std.tree.list2.xsl';

$structure['tables']['outer'] = '#outer_table#';
$structure['tables']['inner'] = '#inner_table#';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '*');

$structure['outer']['fields'][] = array('fieldname' => 'Label');

// identify the column specs - may use 'width' or 'class'
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
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