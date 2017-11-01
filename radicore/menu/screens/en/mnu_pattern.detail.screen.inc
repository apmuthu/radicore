<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_pattern';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '75%');

$structure['main']['fields'][] = array('pattern_id' => 'ID');
$structure['main']['fields'][] = array('pattern_name' => 'Name');
$structure['main']['fields'][] = array('pattern_desc' => 'Description');
$structure['main']['fields'][] = array('visible_screen' => 'Visible screen?');
$structure['main']['fields'][] = array('context_preselect' => 'Context Preselection');
$structure['main']['fields'][] = array('keep_data' => 'Keep Data on exit?');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>