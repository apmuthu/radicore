<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'survey_section';

$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => 10);
$structure['outer']['columns'][] = array('width' => 10);
$structure['outer']['columns'][] = array('width' => '*');

$structure['outer']['fields'][] = array('survey_name' => 'Survey Name', 'colspan' => 3);
$structure['outer']['fields'][2][] = array('label' => 'Section Name');
$structure['outer']['fields'][2][] = array('field' => 'section_seq');
$structure['outer']['fields'][2][] = array('label' => '-');
$structure['outer']['fields'][2][] = array('field' => 'section_name');

$structure['tables']['inner'] = 'survey_question';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 25);
$structure['inner']['columns'][] = array('width' => '*');

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('question_seq' => 'Seq');
$structure['inner']['fields'][] = array('question_text' => 'Text');

?>