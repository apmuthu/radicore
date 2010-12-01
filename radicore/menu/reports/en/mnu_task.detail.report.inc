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
$structure['title'][] = array('text' => '- Contents of MNU_TASK table -',
                              'width' => 100,
                              'align' => 'center',
                              'border' => 'y');

// set column widths
$structure['columns'][] = array('width' => 50, 'halign' => 'right');
$structure['columns'][] = array('width' => 140, 'halign' => 'left');

// identify labels and data to be output

// format 1: one field and label per line
$structure['body']['fields'][] = array('task_id' => 'Task Id');
$structure['body']['fields'][] = array('task_desc' => 'Description');
$structure['body']['fields'][] = array('button_text' => 'Button Text');
$structure['body']['fields'][] = array('task_type' => 'Task Type');
$structure['body']['fields'][] = array('script_id' => 'Script Id');
$structure['body']['fields'][] = array('pattern_id' => 'Pattern Id');
$structure['body']['fields'][] = array('subsys_id' => 'Subsys Id');

$structure['body']['fields'][] = array('initial_passthru' => 'Initial Passthru');
$structure['body']['fields'][] = array('selection_fixed' => 'Selection (fixed)');
$structure['body']['fields'][] = array('selection_temp' => 'Selection (temp)');
$structure['body']['fields'][] = array('settings' => 'Settings');
$structure['body']['fields'][] = array('order_by' => 'Order By');
$structure['body']['fields'][] = array('keep_data' => 'Keep Data?');
$structure['body']['fields'][] = array('log_sql_query' => 'Log SQL Query?');
$structure['body']['fields'][] = array('is_disabled' => 'Disabled?');
$structure['body']['fields'][] = array('screen_refresh' => 'Screen Refresh');
$structure['body']['fields'][] = array('use_https' => 'Use HTTPS?');
$structure['body']['fields'][] = array('max_execution_time' => 'Max Execution Time');
$structure['body']['fields'][] = array('task_id_run_at_end' => 'Run at End');
$structure['body']['fields'][] = array('task_id_run_at_cancel' => 'Run at Cancel');

$structure['body']['fields'][] = array('created_date' => 'Created Date');
$structure['body']['fields'][] = array('created_user' => 'Created By');
$structure['body']['fields'][] = array('revised_date' => 'Revised Date');
$structure['body']['fields'][] = array('revised_user' => 'Revised By');

// define contents of page footer
$structure['foot1'][] = array('type' => 'date', 'align' => 'left', 'style' => 'textalignleft');
$structure['foot1'][] = array('type' => 'pageno', 'align' => 'center');
$structure['foot1'][] = array('type' => 'time', 'align' => 'right', 'style' => 'textalignright');

$structure['foot2'][] = array('text' => 'Radicore Software Limited', 'align' => 'center');

// identify output for 1st additional zone
$structure['multi1']['fields'][1][] = array('label' => 'Seq', 'width' => 10, 'halign' => 'center');
$structure['multi1']['fields'][1][] = array('label' => 'Menu Option', 'width' => 50, 'halign' => 'center');
$structure['multi1']['fields'][1][] = array('label' => 'Option Description', 'width' => 90, 'halign' => 'center');
$structure['multi1']['fields'][1][] = array('label' => 'Button Text', 'width' => 40, 'halign' => 'center');

// identify output for 2nd additional zone
$structure['multi2']['fields'][1][] = array('field' => 'sort_seq', 'width' => 10, 'halign' => 'center');
$structure['multi2']['fields'][1][] = array('field' => 'task_id_jnr', 'width' => 50);
$structure['multi2']['fields'][1][] = array('field' => 'task_desc_jnr', 'width' => 90);
$structure['multi2']['fields'][1][] = array('field' => 'button_text', 'width' => 40);

?>