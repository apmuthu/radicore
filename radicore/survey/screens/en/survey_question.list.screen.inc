<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'survey_section';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('survey_name' => 'Survey Name');
$structure['outer']['fields'][] = array('section_name' => 'Section Name');

$structure['tables']['inner'] = 'survey_question';

$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => 25);
$structure['inner']['columns'][] = array('width' => 500);

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('question_seq' => 'Seq');
$structure['inner']['fields'][] = array('question_text' => 'Text');

?>