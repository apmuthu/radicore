<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'dict_column';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '20%');
$structure['main']['columns'][] = array('width' => '15%');
$structure['main']['columns'][] = array('width' => '15%');
$structure['main']['columns'][] = array('width' => '10%');
$structure['main']['columns'][] = array('width' => '15%');

$structure['main']['fields'][1][] = array('label' => 'Database Id');
$structure['main']['fields'][1][] = array('field' => 'database_id');
$structure['main']['fields'][1][] = array('label' => 'Table Id');
$structure['main']['fields'][1][] = array('field' => 'table_id', 'colspan' => 3);

$structure['main']['fields'][2] = array('column_seq' => 'Seq', 'colspan' => 5);
$structure['main']['fields'][3] = array('column_id' => 'Column Id', 'colspan' => 5);
$structure['main']['fields'][4] = array('column_desc' => 'Description', 'colspan' => 5);
$structure['main']['fields'][5] = array('col_comment' => 'Comments', 'colspan' => 5);

//$structure['main']['fields'][6][] = array('label' => 'Column Type');
//$structure['main']['fields'][6][] = array('field' => 'col_type', 'colspan' => 2);
//$structure['main']['fields'][6][] = array('label' => 'Array Type');
//$structure['main']['fields'][6][] = array('field' => 'col_array_type', 'colspan' => 2);

$structure['main']['fields'][6] = array('col_type' => 'Column Type', 'colspan' => 5);
$structure['main']['fields'][7] = array('col_array_type' => 'Array Type', 'colspan' => 5);

$structure['main']['fields'][8] = array('col_values' => 'Column Values', 'colspan' => 5);

$structure['main']['fields'][9][] = array('label' => 'Column Size');
$structure['main']['fields'][9][] = array('field' => 'user_size');
$structure['main']['fields'][9][] = array('label' => 'Precision');
$structure['main']['fields'][9][] = array('field' => 'col_precision');
$structure['main']['fields'][9][] = array('label' => 'Scale');
$structure['main']['fields'][9][] = array('field' => 'col_scale');

$structure['main']['fields'][10][] = array('label' => 'Null?');
$structure['main']['fields'][10][] = array('field' => 'col_null');
$structure['main']['fields'][10][] = array('label' => 'Required?');
$structure['main']['fields'][10][] = array('field' => 'is_required', 'colspan' => 3);

$structure['main']['fields'][11] = array('col_key' => 'Key?', 'colspan' => 5);
$structure['main']['fields'][12] = array('col_default' => 'Default', 'colspan' => 5);
$structure['main']['fields'][13] = array('col_auto_increment' => 'Auto Increment?', 'colspan' => 5);
$structure['main']['fields'][14] = array('col_attributes' => 'Attributes', 'colspan' => 5);
$structure['main']['fields'][15] = array('custom_validation' => 'Custom Validaton', 'colspan' => 5);

$structure['main']['fields'][16][] = array('label' => 'Unsigned?');
$structure['main']['fields'][16][] = array('field' => 'col_unsigned');
$structure['main']['fields'][16][] = array('label' => 'ZF/BWZ?');
$structure['main']['fields'][16][] = array('field' => 'col_zerofill_bwz', 'colspan' => 3);

$structure['main']['fields'][17] = array('noedit_nodisplay' => 'No Edit/Display', 'colspan' => 5);

$structure['main']['fields'][18][] = array('label' => 'Auto Insert');
$structure['main']['fields'][18][] = array('field' => 'auto_insert');
$structure['main']['fields'][18][] = array('label' => 'Auto Update');
$structure['main']['fields'][18][] = array('field' => 'auto_update', 'colspan' => 3);

$structure['main']['fields'][19] = array('upper_lowercase' => 'Upper/Lowercase', 'colspan' => 5);
$structure['main']['fields'][20] = array('is_password' => 'Password?', 'colspan' => 5);

$structure['main']['fields'][21][] = array('label' => 'No Search');
$structure['main']['fields'][21][] = array('field' => 'no_search');
$structure['main']['fields'][21][] = array('label' => 'No Audit');
$structure['main']['fields'][21][] = array('field' => 'no_audit', 'colspan' => 3);

$structure['main']['fields'][22][] = array('label' => 'Minimum Value');
$structure['main']['fields'][22][] = array('field' => 'user_minvalue', 'size' => 23);
$structure['main']['fields'][22][] = array('label' => 'Max. Value');
$structure['main']['fields'][22][] = array('field' => 'user_maxvalue', 'size' => 22, 'colspan' => 3);

$structure['main']['fields'][23] = array('infinityisnull' => 'Infinity Is Null?', 'colspan' => 5);
$structure['main']['fields'][24] = array('col_subtype' => 'Subtype', 'colspan' => 5);

$structure['main']['fields'][26][] = array('label' => 'Image Width');
$structure['main']['fields'][26][] = array('field' => 'image_width');
$structure['main']['fields'][26][] = array('label' => 'Image Height');
$structure['main']['fields'][26][] = array('field' => 'image_height', 'colspan' => 3);

$structure['main']['fields'][27][] = array('label' => 'True');
$structure['main']['fields'][27][] = array('field' => 'boolean_true');
$structure['main']['fields'][27][] = array('label' => 'False');
$structure['main']['fields'][27][] = array('field' => 'boolean_false', 'colspan' => 3);

$structure['main']['fields'][28] = array('control' => 'Control', 'colspan' => 5);

$structure['main']['fields'][29][] = array('label' => 'No. of Rows');
$structure['main']['fields'][29][] = array('field' => 'multi_rows');
$structure['main']['fields'][29][] = array('label' => 'No. of Columns');
$structure['main']['fields'][29][] = array('field' => 'multi_cols', 'colspan' => 3);

$structure['main']['fields'][30] = array('optionlist' => 'Option List', 'colspan' => 5);
$structure['main']['fields'][31] = array('checkbox_label' => 'Checkbox Label', 'colspan' => 5);
$structure['main']['fields'][32] = array('task_id' => 'Task Id', 'colspan' => 5);
$structure['main']['fields'][33] = array('foreign_field' => 'Foreign Field', 'colspan' => 5);

$structure['main']['fields'][34][] = array('label' => 'Align H/V');
$structure['main']['fields'][34][] = array('field' => 'align_hv');
$structure['main']['fields'][34][] = array('label' => 'Align L/R');
$structure['main']['fields'][34][] = array('field' => 'align_lr', 'colspan' => 3);

$structure['main']['fields'][35][] = array('label' => 'Created Date');
$structure['main']['fields'][35][] = array('field' => 'created_date', 'colspan' => 2);
$structure['main']['fields'][35][] = array('label' => 'Created By',);
$structure['main']['fields'][35][] = array('field' => 'created_user', 'colspan' => 2);

$structure['main']['fields'][36][] = array('label' => 'Revised Date');
$structure['main']['fields'][36][] = array('field' => 'revised_date', 'colspan' => 2);
$structure['main']['fields'][36][] = array('label' => 'Revised By');
$structure['main']['fields'][36][] = array('field' => 'revised_user', 'colspan' => 2);

?>