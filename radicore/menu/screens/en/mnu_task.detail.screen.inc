<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_task';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '75%');

$structure['main']['fields'][] = array('task_id' => 'Task');
$structure['main']['fields'][] = array('task_desc' => 'Description');
$structure['main']['fields'][] = array('button_text' => 'Button Text');
$structure['main']['fields'][] = array('task_type' => 'Type');
$structure['main']['fields'][] = array('dialog_type_id' => 'Dialog Type');
$structure['main']['fields'][] = array('subsys_id' => 'Subsystem');
$structure['main']['fields'][] = array('script_id' => 'Script ID');
$structure['main']['fields'][] = array('initial_passthru' => 'Initial Passthru');
$structure['main']['fields'][] = array('selection_fixed' => 'Selection (fixed)');
$structure['main']['fields'][] = array('selection_temp' => 'Selection (temporary)');
$structure['main']['fields'][] = array('settings' => 'Settings');
$structure['main']['fields'][] = array('order_by' => 'Order By');
$structure['main']['fields'][] = array('keep_data' => 'Keep Data on exit?');
$structure['main']['fields'][] = array('is_disabled' => 'Task Disabled?');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');
$structure['main']['fields'][] = array('selected' => 'Selected');

?>