<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'dict_relationship_snr';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '24%');
$structure['main']['columns'][] = array('width' => '18%');
$structure['main']['columns'][] = array('width' => '35%');

$structure['main']['fields'][1][1] = array('label' => 'Database Id (snr)', 'rowspan' => 2);
$structure['main']['fields'][1][2] = array('field' => 'database_id_snr', 'size' => 20, 'rowspan' => 2);
$structure['main']['fields'][1][3] = array('label' => 'Table Id (snr)');
$structure['main']['fields'][1][4] = array('field' => 'table_id_snr');

$structure['main']['fields'][2][3] = array('label' => 'Alias (snr)');
$structure['main']['fields'][2][4] = array('field' => 'table_alias_snr', 'size' => 35);

$structure['main']['fields'][3][1] = array('label' => 'Database Id (jnr)', 'rowspan' => 2);
$structure['main']['fields'][3][2] = array('field' => 'database_id_jnr', 'size' => 20, 'rowspan' => 2);
$structure['main']['fields'][3][3] = array('label' => 'Table Id (jnr)');
$structure['main']['fields'][3][4] = array('field' => 'table_id_jnr');

$structure['main']['fields'][4][3] = array('label' => 'Alias (jnr)');
$structure['main']['fields'][4][4] = array('field' => 'table_alias_jnr', 'size' => 35);

$structure['main']['fields'][] = array('seq_no' => 'Seq Number', 'colspan' => 3);
$structure['main']['fields'][] = array('relation_name' => 'Name', 'colspan' => 3);
$structure['main']['fields'][] = array('relation_desc' => 'Description', 'colspan' => 3);
$structure['main']['fields'][] = array('relation_type' => 'Relationship Type', 'colspan' => 3);
$structure['main']['fields'][] = array('orderby' => 'Order By', 'colspan' => 3);
$structure['main']['fields'][] = array('parent_field' => 'Parent Field', 'colspan' => 3);
$structure['main']['fields'][] = array('calc_field' => 'Calculated Field', 'colspan' => 3);
$structure['main']['fields'][] = array('key_name' => 'Key Name', 'colspan' => 3);
$structure['main']['fields'][] = array('created_date' => 'Created Date', 'colspan' => 3);
$structure['main']['fields'][] = array('created_user' => 'Created By', 'colspan' => 3);
$structure['main']['fields'][] = array('revised_date' => 'Revised Date', 'colspan' => 3);
$structure['main']['fields'][] = array('revised_user' => 'Revised By', 'colspan' => 3);

?>