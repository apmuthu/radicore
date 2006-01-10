<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'wf_place';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('workflow_id' => 'Workflow Id');
$structure['main']['fields'][] = array('workflow_name' => 'Workflow Name');
$structure['main']['fields'][] = array('place_id' => 'Place Id');
$structure['main']['fields'][] = array('place_name' => 'Place Name');
$structure['main']['fields'][] = array('place_desc' => 'Description');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>