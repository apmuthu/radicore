<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_todo';

// identify the column specs - may use 'width' or 'class'
$structure['main']['columns'][] = array('width' => '25%');

// identify the contents of each row in the table (two formats are allowed)
$structure['main']['fields'][] = array('user_id' => 'User Id');
$structure['main']['fields'][] = array('seq_no' => 'Seq No');
$structure['main']['fields'][] = array('item_desc' => 'Description');
$structure['main']['fields'][] = array('item_notes' => 'Notes');
$structure['main']['fields'][] = array('due_date' => 'Due Date');
$structure['main']['fields'][] = array('is_complete' => 'Completed?');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>