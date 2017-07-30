<?php
$structure['xsl_file'] = 'std.list2.xsl';

$structure['tables']['outer'] = 'dict_relationship';

$structure['outer']['columns'][] = array('width' => '25%');
$structure['outer']['columns'][] = array('width' => '24%');
$structure['outer']['columns'][] = array('width' => '18%');
$structure['outer']['columns'][] = array('width' => '*');

$structure['outer']['fields'][1][] = array('label' => 'Database Id (snr)', 'rowspan' => 2);
$structure['outer']['fields'][1][] = array('field' => 'database_id_snr', 'rowspan' => 2);
$structure['outer']['fields'][1][] = array('label' => 'Table Id (snr)');
$structure['outer']['fields'][1][] = array('field' => 'table_id_snr');
$structure['outer']['fields'][2] = array('table_alias_snr' => 'Alias (snr)', 'size' => 35);

$structure['outer']['fields'][3][] = array('label' => 'Database Id (jnr)', 'rowspan' => 2);
$structure['outer']['fields'][3][] = array('field' => 'database_id_jnr', 'rowspan' => 2);
$structure['outer']['fields'][3][] = array('label' => 'Table Id (jnr)');
$structure['outer']['fields'][3][] = array('field' => 'table_id_jnr');
$structure['outer']['fields'][] = array('table_alias_jnr' => 'Alias (jnr)', 'size' => 35);

$structure['outer']['fields'][] = array('seq_no' => 'Seq Number', 'colspan' => 3);
$structure['outer']['fields'][] = array('relation_name' => 'Name', 'colspan' => 3);
$structure['outer']['fields'][] = array('relation_desc' => 'Description', 'colspan' => 3);
$structure['outer']['fields'][] = array('relation_type' => 'Relationship Type', 'colspan' => 3);
$structure['outer']['fields'][] = array('orderby' => 'Order By', 'colspan' => 3);
$structure['outer']['fields'][] = array('parent_field' => 'Parent Field', 'colspan' => 3);
$structure['outer']['fields'][] = array('calc_field' => 'Calculated Field', 'colspan' => 3);
$structure['outer']['fields'][] = array('key_name' => 'Key Name', 'colspan' => 3);

$structure['tables']['inner'] = 'dict_related_column';

$structure['inner']['columns'][] = array('width' => '50%');
$structure['inner']['columns'][] = array('width' => '50%');

$structure['inner']['fields'][] = array('column_id_snr' => 'Column Id (snr)');
$structure['inner']['fields'][] = array('column_id_jnr' => 'Column Id (jnr)');

?>