<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'dict_table';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('database_id' => 'Database Id', 'colspan' => 3);
$structure['main']['fields'][] = array('table_id' => 'Table Id', 'colspan' => 3);

$structure['main']['fields'][3][] = array('label' => 'Directory');
$structure['main']['fields'][3][] = array('field' => 'subsys_dir');
$structure['main']['fields'][3][] = array('label' => 'Task Prefix');
$structure['main']['fields'][3][] = array('field' => 'task_prefix');

$structure['main']['fields'][] = array('pattern_name' => 'Pattern', 'colspan' => 3);
$structure['main']['fields'][] = array('task_id' => 'Task ID', 'colspan' => 3);
$structure['main']['fields'][] = array('script_id' => 'Script ID', 'colspan' => 3);
$structure['main']['fields'][] = array('tablename' => 'Table Name', 'colspan' => 3);
$structure['main']['fields'][] = array('table_alias' => 'Table Alias', 'colspan' => 3);
$structure['main']['fields'][] = array('database_id_outer' => 'Outer Database', 'colspan' => 3);
$structure['main']['fields'][] = array('outer_table' => 'Outer Table Name', 'colspan' => 3);
$structure['main']['fields'][] = array('outer_table_alias' => 'Outer Table Alias', 'colspan' => 3);
$structure['main']['fields'][] = array('link_table' => 'Link Table Name', 'colspan' => 3);
$structure['main']['fields'][] = array('middle_table' => 'Middle Table Name', 'colspan' => 3);
$structure['main']['fields'][] = array('database_id_inner' => 'Inner Database', 'colspan' => 3);
$structure['main']['fields'][] = array('inner_table' => 'Inner Table Name', 'colspan' => 3);
$structure['main']['fields'][] = array('inner_table_alias' => 'Inner Table Alias', 'colspan' => 3);
$structure['main']['fields'][] = array('screen_file' => 'Screen Structure', 'colspan' => 3);
$structure['main']['fields'][] = array('report_file' => 'Report Structure', 'colspan' => 3);
$structure['main']['fields'][] = array('child_forms' => 'Child Forms', 'colspan' => 3);
$structure['main']['fields'][] = array('popup_task_id' => 'Popup Task', 'colspan' => 3);

?>