<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_dialog_type';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '75%');

$structure['main']['fields'][] = array('dialog_type_id' => 'ID');
$structure['main']['fields'][] = array('dialog_type_desc' => 'Description');
$structure['main']['fields'][] = array('dialog_type_long_desc' => 'Long Description');
$structure['main']['fields'][] = array('visible_screen' => 'Visible screen?');
$structure['main']['fields'][] = array('context_preselect' => 'Context Preselection');
$structure['main']['fields'][] = array('keep_data' => 'Keep Data on exit?');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

?>