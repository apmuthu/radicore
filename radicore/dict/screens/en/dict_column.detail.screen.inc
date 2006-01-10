<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'dict_column';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '17%');
$structure['main']['columns'][] = array('width' => '33%');

$structure['main']['fields'][1][] = array('label' => 'Database Id');
$structure['main']['fields'][1][] = array('field' => 'database_id');
$structure['main']['fields'][1][] = array('label' => 'Table Id');
$structure['main']['fields'][1][] = array('field' => 'table_id');

$structure['main']['fields'][2] = array('column_seq' => 'Seq', 'colspan' => 3);
$structure['main']['fields'][3] = array('column_id' => 'Column Id', 'colspan' => 3);
$structure['main']['fields'][4] = array('column_desc' => 'Description', 'colspan' => 3);
$structure['main']['fields'][5] = array('comment' => 'Comments', 'colspan' => 3);
$structure['main']['fields'][6] = array('col_type' => 'Column Type', 'colspan' => 3);
$structure['main']['fields'][7] = array('col_values' => 'Column Values', 'colspan' => 3);
$structure['main']['fields'][8] = array('user_size' => 'Column Size', 'colspan' => 3);

$structure['main']['fields'][9][] = array('label' => 'Precision');
$structure['main']['fields'][9][] = array('field' => 'col_precision');
$structure['main']['fields'][9][] = array('label' => 'Scale');
$structure['main']['fields'][9][] = array('field' => 'col_scale');

$structure['main']['fields'][10] = array('col_null' => 'Null?', 'colspan' => 3);
$structure['main']['fields'][11] = array('is_required' => 'Required?', 'colspan' => 3);
$structure['main']['fields'][12] = array('col_key' => 'Key?', 'colspan' => 3);
$structure['main']['fields'][13] = array('col_default' => 'Default', 'colspan' => 3);
$structure['main']['fields'][14] = array('col_auto_increment' => 'Auto Increment?', 'colspan' => 3);
$structure['main']['fields'][15] = array('col_attributes' => 'Attributes', 'colspan' => 3);

$structure['main']['fields'][16][] = array('label' => 'Unsigned?');
$structure['main']['fields'][16][] = array('field' => 'col_unsigned');
$structure['main']['fields'][16][] = array('label' => 'ZF/BWZ?');
$structure['main']['fields'][16][] = array('field' => 'col_zerofill_bwz');

$structure['main']['fields'][17] = array('noedit_nodisplay' => 'No Edit/Display', 'colspan' => 3);

$structure['main']['fields'][18][] = array('label' => 'Auto Insert');
$structure['main']['fields'][18][] = array('field' => 'auto_insert');
$structure['main']['fields'][18][] = array('label' => 'Auto Update');
$structure['main']['fields'][18][] = array('field' => 'auto_update');

$structure['main']['fields'][20] = array('upper_lowercase' => 'Uppercase/Lowercase', 'colspan' => 3);
$structure['main']['fields'][21] = array('is_password' => 'Password?', 'colspan' => 3);

$structure['main']['fields'][22][] = array('label' => 'No Search');
$structure['main']['fields'][22][] = array('field' => 'nosearch');
$structure['main']['fields'][22][] = array('label' => 'No Audit');
$structure['main']['fields'][22][] = array('field' => 'noaudit');

$structure['main']['fields'][23][] = array('label' => 'Minimum Value');
$structure['main']['fields'][23][] = array('field' => 'user_minvalue');
$structure['main']['fields'][23][] = array('label' => 'Max. Value');
$structure['main']['fields'][23][] = array('field' => 'user_maxvalue');

$structure['main']['fields'][25] = array('infinityisnull' => 'Infinity Is Null?', 'colspan' => 3);
$structure['main']['fields'][26] = array('subtype' => 'Subtype', 'colspan' => 3);

$structure['main']['fields'][27][] = array('label' => 'Image Width');
$structure['main']['fields'][27][] = array('field' => 'image_width');
$structure['main']['fields'][27][] = array('label' => 'Image Height');
$structure['main']['fields'][27][] = array('field' => 'image_height');

$structure['main']['fields'][28][] = array('label' => 'True');
$structure['main']['fields'][28][] = array('field' => 'boolean_true');
$structure['main']['fields'][28][] = array('label' => 'False');
$structure['main']['fields'][28][] = array('field' => 'boolean_false');

$structure['main']['fields'][29] = array('control' => 'Control', 'colspan' => 3);
$structure['main']['fields'][30] = array('optionlist' => 'Option List', 'colspan' => 3);
$structure['main']['fields'][31] = array('task_id' => 'Task Id', 'colspan' => 3);
$structure['main']['fields'][32] = array('foreign_field' => 'Foreign Field', 'colspan' => 3);
$structure['main']['fields'][33] = array('align_hv' => 'Alignment', 'colspan' => 3);

$structure['main']['fields'][34][] = array('label' => 'No. of Columns');
$structure['main']['fields'][34][] = array('field' => 'multi_cols');
$structure['main']['fields'][34][] = array('label' => 'No. of Rows');
$structure['main']['fields'][34][] = array('field' => 'multi_rows');

$structure['main']['fields'][] = array('created_date' => 'Created Date', 'colspan' => 3);
$structure['main']['fields'][] = array('created_user' => 'Created By', 'colspan' => 3);
$structure['main']['fields'][] = array('revised_date' => 'Revised Date', 'colspan' => 3);
$structure['main']['fields'][] = array('revised_user' => 'Revised By', 'colspan' => 3);

?>