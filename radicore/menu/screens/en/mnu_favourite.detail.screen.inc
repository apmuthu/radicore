<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_favourite';

// identify the column specs - may use 'width' or 'class'
$structure['main']['columns'][] = array('width' => '20%');
$structure['main']['columns'][] = array('width' => 100);
$structure['main']['columns'][] = array('width' => 100);
$structure['main']['columns'][] = array('width' => '*');

// identify the contents of each row in the table (two formats are allowed)
// the SHORT format defines two cells per row, a label followed by a field, as in:
$structure['main']['fields'][1][] = array('label' => 'User Id');
$structure['main']['fields'][1][] = array('field' => 'user_id');
$structure['main']['fields'][1][] = array('label' => 'User Name');
$structure['main']['fields'][1][] = array('field' => 'user_name');

$structure['main']['fields'][2][] = array('label' => 'Sequence Number');
$structure['main']['fields'][2][] = array('field' => 'seq_no');
$structure['main']['fields'][2][] = array('label' => 'Sort Sequence');
$structure['main']['fields'][2][] = array('field' => 'sort_seq');

$structure['main']['fields'][] = array('task_id' => 'Task Id', 'colspan' => 3);
$structure['main']['fields'][] = array('task_desc' => 'Task Desc', 'colspan' => 3);

//$structure['main']['fields'][] = array('breadcrumbs' => 'Breadcrumbs', 'colspan' => 3);

$structure['main']['fields'][] = array('created_date' => 'Created Date', 'colspan' => 3);
$structure['main']['fields'][] = array('created_user' => 'Created User', 'colspan' => 3);
$structure['main']['fields'][] = array('revised_date' => 'Revised Date', 'colspan' => 3);
$structure['main']['fields'][] = array('revised_user' => 'Revised User', 'colspan' => 3);

?>