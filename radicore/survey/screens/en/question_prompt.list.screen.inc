<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'survey_question';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('survey_name' => 'Survey Name');
$structure['outer']['fields'][] = array('section_name' => 'Section Name');
$structure['outer']['fields'][] = array('question_seq' => 'Question Seq');
$structure['outer']['fields'][] = array('question_text' => 'Question Text');

$structure['tables']['inner'] = 'question_prompt';

$structure['inner']['columns'][] = array('width' => 5);

$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('prompt_desc' => 'Prompt');

?>