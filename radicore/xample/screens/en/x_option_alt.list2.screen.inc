<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'x_option';

// identify the column specs - may use 'width' or 'class'
$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '*');

// identify the field names and their screen labels
$structure['outer']['fields'][] = array('option_id' => 'Option Id');
$structure['outer']['fields'][] = array('option_desc' => 'Option Description');
$structure['outer']['fields'][] = array('created_date' => 'Created Date');
$structure['outer']['fields'][] = array('created_user' => 'Created User');
$structure['outer']['fields'][] = array('revised_date' => 'Revised Date');
$structure['outer']['fields'][] = array('revised_user' => 'Revised User');

$structure['tables']['inner'] = 'x_option_alt';

// identify the column specs - may use 'width' or 'class'
$structure['inner']['columns'][] = array('width' => 5);
$structure['inner']['columns'][] = array('width' => '14,29%');
$structure['inner']['columns'][] = array('width' => '14,29%');
$structure['inner']['columns'][] = array('width' => '14,29%');
$structure['inner']['columns'][] = array('width' => '14,29%');
$structure['inner']['columns'][] = array('width' => '14,29%');
$structure['inner']['columns'][] = array('width' => '14,29%');
$structure['inner']['columns'][] = array('width' => '14,29%');

// identify the field names and their screen labels
$structure['inner']['fields'][] = array('selectbox' => 'Select');
$structure['inner']['fields'][] = array('option_id' => 'Option Id');
$structure['inner']['fields'][] = array('language_id' => 'Language Id');
$structure['inner']['fields'][] = array('option_desc' => 'Option Desc');
$structure['inner']['fields'][] = array('created_date' => 'Created Date');
$structure['inner']['fields'][] = array('created_user' => 'Created User');
$structure['inner']['fields'][] = array('revised_date' => 'Revised Date');
$structure['inner']['fields'][] = array('revised_user' => 'Revised User');

// the NOSORT keyword is optional, and will prevent the label from being a hyperlink
// which will allow the data to be sorted on that column

?>