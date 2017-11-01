<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'answer_option';

$structure['main']['columns'][] = array('width' => '20%');

$structure['main']['fields'][] = array('survey_name' => 'Survey Name');
$structure['main']['fields'][] = array('section_id' => 'Section Id');
$structure['main']['fields'][] = array('section_seq' => 'Section Seq');
$structure['main']['fields'][] = array('section_name' => 'Section Name');
$structure['main']['fields'][] = array('question_seq' => 'Question');
$structure['main']['fields'][] = array('question_id' => 'Question Id');
$structure['main']['fields'][] = array('question_text' => 'Question Text');
$structure['main']['fields'][] = array('answer_id' => 'Answer Id');
$structure['main']['fields'][] = array('answer_seq' => 'Answer Sequence');
$structure['main']['fields'][] = array('answer_text' => 'Answer Text');
$structure['main']['fields'][] = array('jumpto_section_seq' => 'Junp To Section');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>