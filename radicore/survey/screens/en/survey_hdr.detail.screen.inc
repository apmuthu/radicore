<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'survey_hdr';

$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('survey_id' => 'Id');
$structure['main']['fields'][] = array('survey_name' => 'Name');
$structure['main']['fields'][] = array('survey_long_name' => 'Long Name');
$structure['main']['fields'][] = array('survey_type_id' => 'Survey Type');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>