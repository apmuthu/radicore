<?php
$structure['xsl_file'] = 'std.link1.xsl';

$structure['tables']['outer'] = 'survey_question';

$structure['outer']['columns'][] = array('width' => '25%');

$structure['outer']['fields'][] = array('survey_name' => 'Survey Name');
$structure['outer']['fields'][] = array('section_name' => 'Section Name');
$structure['outer']['fields'][] = array('question_seq' => 'Question Seq');
$structure['outer']['fields'][] = array('question_text' => 'Question Text');

$structure['tables']['link'] = 'question_prompt';

$structure['link']['columns'][] = array('width' => 5);

$structure['link']['fields'][] = array('selectbox' => 'Select');
$structure['link']['fields'][] = array('prompt_desc' => 'Prompt');

?>