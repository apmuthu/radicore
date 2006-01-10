<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'mnu_user';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '25%');

// identify the field names and their screen labels
$structure['outer']['fields'][] = array('user_name' => 'User');

$structure['tables']['inner'] = 'mnu_todo';

// identify the column specs - may use 'width' or 'class'
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 100);
$structure['inner']['columns'][] = array('width' => 30);

// identify the field names and their screen labels
$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('item_desc' => 'Description');
$structure['inner']['fields'][] = array('due_date' => 'Due Date');
$structure['inner']['fields'][] = array('is_complete' => 'Done?');

?>