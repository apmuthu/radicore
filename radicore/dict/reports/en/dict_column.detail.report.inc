<?php
// report structure for a DETAIL view

$structure['pdf'] = array('orientation' => 'P',     // L=Landscape, P=Portrait
                          'units' => 'mm',          // pt=Point, mm=Millimeter, cm=Centimeter, in=Inch
                          'format' => 'A4',         // A3, A4, A5, Letter, Legal
                          'name' => '',             // filename (if destination = D or F)
                          'destination' => 'I');    // I=Inline (browser), D=Download (browser), F=Filename (on server), S=String

$structure['title']['style'] = 'title';             // style for page heading
$structure['label']['style'] = 'label';             // style for field labels
$structure['data']['style']  = 'data';              // style for field data
$structure['foot']['style']  = 'foot';              // style for page footer

// define contents of page title
$structure['title'][] = array('text' => '- Contents of DICT_COLUMN table -',
                              'width' => 100,
                              'align' => 'center',
                              'border' => 'y');

// set column widths
$structure['columns'][] = array('width' => 40, 'halign' => 'right');
$structure['columns'][] = array('width' => 150, 'halign' => 'left');

// identify labels and data to be output
$structure['body']['fields'][1][] = array('label' => 'Database Id', 'width' => 40);
$structure['body']['fields'][1][] = array('field' => 'database_id', 'width' => 55);
$structure['body']['fields'][1][] = array('label' => 'Table Id', 'width' => 40);
$structure['body']['fields'][1][] = array('field' => 'table_id', 'width' => 55);

$structure['body']['fields'][2] = array('column_seq' => 'Seq');
$structure['body']['fields'][3] = array('column_id' => 'Column Id');
$structure['body']['fields'][4] = array('column_desc' => 'Description');
$structure['body']['fields'][5] = array('col_comment' => 'Comments');

$structure['body']['fields'][6][] = array('label' => 'Column Type', 'width' => 40);
$structure['body']['fields'][6][] = array('field' => 'col_type', 'width' => 55);
$structure['body']['fields'][6][] = array('label' => 'Array Type', 'width' => 40);
$structure['body']['fields'][6][] = array('field' => 'col_array_type', 'width' => 55);

$structure['body']['fields'][7] = array('col_values' => 'Column Values');

$structure['body']['fields'][9][] = array('label' => 'Column Size', 'width' => 40);
$structure['body']['fields'][9][] = array('field' => 'user_size', 'width' => 20);
$structure['body']['fields'][9][] = array('label' => 'Precision', 'width' => 40);
$structure['body']['fields'][9][] = array('field' => 'col_precision', 'width' => 20);
$structure['body']['fields'][9][] = array('label' => 'Scale', 'width' => 40);
$structure['body']['fields'][9][] = array('field' => 'col_scale', 'width' => 30);

$structure['body']['fields'][10][] = array('label' => 'Null?', 'width' => 40);
$structure['body']['fields'][10][] = array('field' => 'col_null', 'width' => 55);
$structure['body']['fields'][10][] = array('label' => 'Required?', 'width' => 40);
$structure['body']['fields'][10][] = array('field' => 'is_required', 'width' => 55);

$structure['body']['fields'][12] = array('col_key' => 'Key?');
$structure['body']['fields'][13] = array('col_default' => 'Default');
$structure['body']['fields'][14] = array('col_auto_increment' => 'Auto Increment?');
$structure['body']['fields'][15] = array('col_attributes' => 'Attributes');

$structure['body']['fields'][16][] = array('label' => 'Unsigned?', 'width' => 40);
$structure['body']['fields'][16][] = array('field' => 'col_unsigned', 'width' => 55);
$structure['body']['fields'][16][] = array('label' => 'ZF/BWZ?', 'width' => 40);
$structure['body']['fields'][16][] = array('field' => 'col_zerofill_bwz', 'width' => 55);

$structure['body']['fields'][17] = array('noedit_nodisplay' => 'No Edit/Display');

$structure['body']['fields'][18][] = array('label' => 'Auto Insert', 'width' => 40);
$structure['body']['fields'][18][] = array('field' => 'auto_insert', 'width' => 55);
$structure['body']['fields'][18][] = array('label' => 'Auto Update', 'width' => 40);
$structure['body']['fields'][18][] = array('field' => 'auto_update', 'width' => 55);

$structure['body']['fields'][19] = array('upper_lowercase' => 'Upper/Lowercase');
$structure['body']['fields'][20] = array('is_password' => 'Password?');

$structure['body']['fields'][21][] = array('label' => 'No Search', 'width' => 40);
$structure['body']['fields'][21][] = array('field' => 'no_search', 'width' => 55);
$structure['body']['fields'][21][] = array('label' => 'No Audit', 'width' => 40);
$structure['body']['fields'][21][] = array('field' => 'no_audit', 'width' => 55);

$structure['body']['fields'][22][] = array('label' => 'Minimum Value', 'width' => 40);
$structure['body']['fields'][22][] = array('field' => 'user_minvalue', 'width' => 55);
$structure['body']['fields'][22][] = array('label' => 'Max. Value', 'width' => 40);
$structure['body']['fields'][22][] = array('field' => 'user_maxvalue', 'width' => 55);

$structure['body']['fields'][23] = array('infinityisnull' => 'Infinity Is Null?');
$structure['body']['fields'][24] = array('col_subtype' => 'Subtype');
$structure['body']['fields'][25] = array('custom_validation' => 'Custom Validation');

$structure['body']['fields'][26][] = array('label' => 'Image Width', 'width' => 40);
$structure['body']['fields'][26][] = array('field' => 'image_width', 'width' => 55);
$structure['body']['fields'][26][] = array('label' => 'Image Height', 'width' => 40);
$structure['body']['fields'][26][] = array('field' => 'image_height', 'width' => 55);

$structure['body']['fields'][27][] = array('label' => 'True', 'width' => 40);
$structure['body']['fields'][27][] = array('field' => 'boolean_true', 'width' => 55);
$structure['body']['fields'][27][] = array('label' => 'False', 'width' => 40);
$structure['body']['fields'][27][] = array('field' => 'boolean_false', 'width' => 55);

$structure['body']['fields'][28] = array('control' => 'Control');

$structure['body']['fields'][29][] = array('label' => 'No. of Rows', 'width' => 40);
$structure['body']['fields'][29][] = array('field' => 'multi_rows', 'width' => 55);
$structure['body']['fields'][29][] = array('label' => 'No. of Columns', 'width' => 40);
$structure['body']['fields'][29][] = array('field' => 'multi_cols', 'width' => 55);

$structure['body']['fields'][30] = array('optionlist' => 'Option List');
$structure['body']['fields'][31] = array('checkbox_label' => 'Checkbox Label');
$structure['body']['fields'][32] = array('task_id' => 'Task Id');
$structure['body']['fields'][33] = array('foreign_field' => 'Foreign Field');

$structure['body']['fields'][34][] = array('label' => 'Align H/V', 'width' => 40);
$structure['body']['fields'][34][] = array('field' => 'align_hv', 'width' => 55);
$structure['body']['fields'][34][] = array('label' => 'Align L/R', 'width' => 40);
$structure['body']['fields'][34][] = array('field' => 'align_lr', 'width' => 55);

$structure['body']['fields'][35][] = array('label' => 'Created Date', 'width' => 40);
$structure['body']['fields'][35][] = array('field' => 'created_date', 'width' => 55);
$structure['body']['fields'][35][] = array('label' => 'Created By', 'width' => 40);
$structure['body']['fields'][35][] = array('field' => 'created_user', 'width' => 55);

$structure['body']['fields'][36][] = array('label' => 'Revised Date', 'width' => 40);
$structure['body']['fields'][36][] = array('field' => 'revised_date', 'width' => 55);
$structure['body']['fields'][36][] = array('label' => 'Revised By', 'width' => 40);
$structure['body']['fields'][36][] = array('field' => 'revised_user', 'width' => 55);

// define contents of page footer
$structure['foot1'][] = array('type' => 'date', 'align' => 'left', 'halign' => 'left');
$structure['foot1'][] = array('type' => 'pageno', 'align' => 'center');
$structure['foot1'][] = array('type' => 'time', 'align' => 'right', 'halign' => 'right');

$structure['foot2'][] = array('text' => 'Radicore Software Limited', 'align' => 'center');

?>