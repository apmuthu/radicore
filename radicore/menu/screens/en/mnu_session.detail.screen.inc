<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_session';

$structure['main']['columns'][] = array('width' => '30%');
$structure['main']['columns'][] = array('width' => '70%');

$structure['main']['fields'][] = array('log_xml_document' => 'Log XML documents?');
$structure['main']['fields'][] = array('log_sql_query' => 'Log SQL queries?');
$structure['main']['fields'][] = array('drop_saved_pages' => 'Drop saved pages?');
$structure['main']['fields'][] = array('css_file' => 'Theme/Style');
$structure['main']['fields'][] = array('allow_responsive_gui' => 'Allow Responsive GUI?');

?>