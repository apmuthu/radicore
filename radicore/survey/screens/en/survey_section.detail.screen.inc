<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'survey_section';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => 10);
$structure['main']['columns'][] = array('width' => 15);
$structure['main']['columns'][] = array('width' => '62%');

$structure['main']['fields'][1][] = array('label' => 'Survey Id');
$structure['main']['fields'][1][] = array('field' => 'survey_id');
$structure['main']['fields'][1][] = array('label' => 'Name');
$structure['main']['fields'][1][] = array('field' => 'survey_name');

$structure['main']['fields'][2] = array('section_seq' => 'Section Seq', 'colspan' => 3);

$structure['main']['fields'][3][] = array('label' => 'Section Id');
$structure['main']['fields'][3][] = array('field' => 'section_id');
$structure['main']['fields'][3][] = array('label' => 'Name');
$structure['main']['fields'][3][] = array('field' => 'section_name');

$structure['main']['fields'][] = array('created_date' => 'Created Date', 'colspan' => 3);
$structure['main']['fields'][] = array('created_user' => 'Created By', 'colspan' => 3);
$structure['main']['fields'][] = array('revised_date' => 'Revised Date', 'colspan' => 3);
$structure['main']['fields'][] = array('revised_user' => 'Revised By', 'colspan' => 3);

?>