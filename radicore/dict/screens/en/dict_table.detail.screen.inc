<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'dict_table';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '15%');
$structure['main']['columns'][] = array('width' => '35%');

$structure['main']['fields'][1][] = array('label' => 'Database Id');
$structure['main']['fields'][1][] = array('field' => 'database_id');
$structure['main']['fields'][1][] = array('label' => 'Table Id');
$structure['main']['fields'][1][] = array('field' => 'table_id', 'size' => 35);

$structure['main']['fields'][] = array('table_name' => 'Name', 'colspan' => 3);
$structure['main']['fields'][] = array('table_desc' => 'Description', 'colspan' => 3);
$structure['main']['fields'][] = array('audit_logging' => 'Audit Logging?', 'colspan' => 3);
$structure['main']['fields'][] = array('default_orderby' => 'Default Sort Seq', 'colspan' => 3);
$structure['main']['fields'][] = array('alt_language_table' => 'Alternative Language Table', 'colspan' => 3);
$structure['main']['fields'][] = array('alt_language_cols' => 'Alternative Language Columns', 'colspan' => 3);
$structure['main']['fields'][] = array('nameof_start_date' => 'Alias for START_DATE', 'colspan' => 3);
$structure['main']['fields'][] = array('nameof_end_date' => 'Alias for END_DATE', 'colspan' => 3);

$structure['main']['fields'][] = array('created_date' => 'Created Date', 'colspan' => 3);
$structure['main']['fields'][] = array('created_user' => 'Created By', 'colspan' => 3);
$structure['main']['fields'][] = array('revised_date' => 'Revised Date', 'colspan' => 3);
$structure['main']['fields'][] = array('revised_user' => 'Revised By', 'colspan' => 3);

?>