<?php
$structure['xsl_file'] = 'std.list1.xsl';

$structure['tables']['main'] = 'mnu_todo';

// identify the column specs - may use 'width' or 'class'
$structure['main']['columns'][] = array('width' => 5);
$structure['main']['columns'][] = array('width' => 175);
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => '*');
$structure['main']['columns'][] = array('width' => 110);
$structure['main']['columns'][] = array('width' => 30);

// identify the field names and their screen labels
$structure['main']['fields'][] = array('selectbox' => 'Select');
$structure['main']['fields'][] = array('user_id' => 'User Id');
$structure['main']['fields'][] = array('item_desc' => 'Description');
$structure['main']['fields'][] = array('item_notes' => 'Notes');
$structure['main']['fields'][] = array('due_date' => 'Due Date');
$structure['main']['fields'][] = array('is_complete' => 'Done?');

?>