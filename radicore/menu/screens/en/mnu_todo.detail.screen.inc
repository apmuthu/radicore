<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_todo';

// identify the column specs - may use 'width' or 'class'
$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => 150);
$structure['main']['columns'][] = array('width' => 150);
$structure['main']['columns'][] = array('width' => '*');

// identify the contents of each row in the table (two formats are allowed)
$structure['main']['fields'][1][] = array('label' => 'User Id');
$structure['main']['fields'][1][] = array('field' => 'user_id');
$structure['main']['fields'][1][] = array('field' => '');
$structure['main']['fields'][1][] = array('field' => '');

$structure['main']['fields'][2] = array('seq_no' => 'Seq No', 'colspan' => 3);
$structure['main']['fields'][3] = array('item_desc' => 'Description', 'colspan' => 3);
$structure['main']['fields'][4] = array('item_notes' => 'Notes', 'colspan' => 3);

$structure['main']['fields'][5][] = array('label' => 'Due Date');
$structure['main']['fields'][5][] = array('field' => 'due_date');
$structure['main']['fields'][5][] = array('label' => 'Visibility (days)');
$structure['main']['fields'][5][] = array('field' => 'visibility');

$structure['main']['fields'][6] = array('is_complete' => 'Completed?', 'colspan' => 3);

$structure['main']['fields'][7][] = array('label' => 'Repeat Interval');
$structure['main']['fields'][7][] = array('field' => 'repeat_interval');
$structure['main']['fields'][7][] = array('label' => 'Repeat Unit');
$structure['main']['fields'][7][] = array('field' => 'repeat_unit');

$structure['main']['fields'][] = array('task_id' => 'Task', 'colspan' => 3);
$structure['main']['fields'][] = array('task_context' => 'Task Context', 'colspan' => 3);

$structure['main']['fields'][] = array('created_date' => 'Created Date', 'colspan' => 3);
$structure['main']['fields'][] = array('created_user' => 'Created By', 'colspan' => 3);
$structure['main']['fields'][] = array('revised_date' => 'Revised Date', 'colspan' => 3);
$structure['main']['fields'][] = array('revised_user' => 'Revised By', 'colspan' => 3);

?>