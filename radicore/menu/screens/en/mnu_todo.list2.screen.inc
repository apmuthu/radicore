<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'mnu_user';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => 100);
$structure['outer']['columns'][] = array('width' => 100);
$structure['outer']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['outer']['fields'][1][] = array('label' => 'User Id');
$structure['outer']['fields'][1][] = array('field' => 'user_id');
$structure['outer']['fields'][1][] = array('label' => 'User Name');
$structure['outer']['fields'][1][] = array('field' => 'user_name');

$structure['tables']['inner'] = 'mnu_todo';

// identify the column specs - may use 'width' or 'class'
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => '*');
$structure['inner']['columns'][] = array('width' => 110);
$structure['inner']['columns'][] = array('width' => 30);

// identify the field names and their screen labels
$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('seq_no' => 'Seq');
$structure['inner']['fields'][] = array('item_name' => 'Item Name');
$structure['inner']['fields'][] = array('item_desc' => 'Description');
$structure['inner']['fields'][] = array('due_date' => 'Due Date');
$structure['inner']['fields'][] = array('is_complete' => 'Done?');

?>