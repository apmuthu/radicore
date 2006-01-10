<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'wf_case';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('workflow_id' => 'Workflow');
$structure['main']['fields'][] = array('case_id' => 'Case Id');
$structure['main']['fields'][] = array('case_status' => 'Case Status');
$structure['main']['fields'][] = array('context' => 'Context');
$structure['main']['fields'][] = array('curr_or_hist' => 'Current or Historic');
$structure['main']['fields'][] = array('start_date' => 'Start Date');
$structure['main']['fields'][] = array('end_date' => 'End Date');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>