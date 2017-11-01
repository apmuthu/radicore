<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'wf_arc';

$structure['main']['columns'][] = array('width' => '20%');
$structure['main']['columns'][] = array('width' => '*');

$structure['main']['fields'][] = array('workflow_name' => 'Workflow Name');
$structure['main']['fields'][] = array('place_id' => 'Place Name');
$structure['main']['fields'][] = array('transition_id' => 'Transition Name');
$structure['main']['fields'][] = array('direction' => 'Direction');
$structure['main']['fields'][] = array('arc_type' => 'Arc Type');
$structure['main']['fields'][] = array('pre_condition' => 'Pre-condition');
$structure['main']['fields'][] = array('condition_field' => 'Condition Field');
$structure['main']['fields'][] = array('condition_operator' => 'Condition Operator');
$structure['main']['fields'][] = array('condition_value' => 'Condition Value');

$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>