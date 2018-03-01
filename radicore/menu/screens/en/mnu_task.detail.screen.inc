<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_task';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '25%');

$structure['main']['fields'][] = array('task_id' => 'Task ID', 'colspan' => 3);
$structure['main']['fields'][] = array('task_name' => 'Name', 'colspan' => 3);
$structure['main']['fields'][] = array('task_desc' => 'Description', 'colspan' => 3);
$structure['main']['fields'][] = array('button_text' => 'Button Text', 'colspan' => 3);
$structure['main']['fields'][] = array('task_type' => 'Type', 'colspan' => 3);
$structure['main']['fields'][] = array('pattern_id' => 'Pattern', 'colspan' => 3);
$structure['main']['fields'][] = array('subsys_id' => 'Subsystem', 'colspan' => 3);
$structure['main']['fields'][] = array('is_disabled' => 'Task Disabled?', 'colspan' => 3);
$structure['main']['fields'][] = array('script_id' => 'Script ID', 'colspan' => 3);
$structure['main']['fields'][] = array('initial_passthru' => 'Initial Passthru', 'colspan' => 3);
$structure['main']['fields'][] = array('selection_fixed' => 'Selection (fixed)', 'colspan' => 3);
$structure['main']['fields'][] = array('selection_temp' => 'Selection (temporary)', 'colspan' => 3);
$structure['main']['fields'][] = array('settings' => 'Settings', 'colspan' => 3);
$structure['main']['fields'][] = array('order_by' => 'Order By', 'colspan' => 3);

$structure['main']['fields'][14][] = array('label' => 'Use HTTPS?');
$structure['main']['fields'][14][] = array('field' => 'use_https');
$structure['main']['fields'][14][] = array('label' => 'Keep Data on exit?');
$structure['main']['fields'][14][] = array('field' => 'keep_data');

$structure['main']['fields'][15][] = array('label' => 'Log SQL query?');
$structure['main']['fields'][15][] = array('field' => 'log_sql_query');
$structure['main']['fields'][15][] = array('label' => 'Screen Refresh');
$structure['main']['fields'][15][] = array('field' => 'screen_refresh');

$structure['main']['fields'][16] = array('max_execution_time' => 'Max. Execution Time', 'colspan' => 3);

$structure['main']['fields'][17] = array('task_id_run_at_end' => 'Run at End', 'colspan' => 3);
$structure['main']['fields'][18] = array('task_id_run_at_cancel' => 'Run at Cancel', 'colspan' => 3);

$structure['main']['fields'][19] = array('allow_responsive_gui' => 'Allow Responsive GUI', 'colspan' => 3);

$structure['main']['fields'][20][] = array('label' => 'Created Date');
$structure['main']['fields'][20][] = array('field' => 'created_date');
$structure['main']['fields'][20][] = array('label' => 'Created By');
$structure['main']['fields'][20][] = array('field' => 'created_user');

$structure['main']['fields'][21][] = array('label' => 'Revised Date');
$structure['main']['fields'][21][] = array('field' => 'revised_date');
$structure['main']['fields'][21][] = array('label' => 'Revised By');
$structure['main']['fields'][21][] = array('field' => 'revised_user');

$structure['main']['fields'][22] = array('selected' => 'Selected', 'colspan' => 3);

// this is here in case no multi-field line is displayed, as a browser bug causes
// the output to ignore the 'colspan' attibute
$structure['main']['fields'][23][] = array('label' => '');
$structure['main']['fields'][23][] = array('field' => '');
$structure['main']['fields'][23][] = array('label' => '');
$structure['main']['fields'][23][] = array('field' => '');

?>