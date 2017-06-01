<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_role';

$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '75%');

$structure['main']['fields'][] = array('role_id' => 'Role');
$structure['main']['fields'][] = array('role_name' => 'Name');
$structure['main']['fields'][] = array('role_desc' => 'Description');
$structure['main']['fields'][] = array('start_task_id' => 'Start Task');
$structure['main']['fields'][] = array('global_access' => 'Global Access');
$structure['main']['fields'][] = array('is_external_auth_off' => 'External Authentication Off?');
$structure['main']['fields'][] = array('allow_responsive_gui' => 'Allow Responsive GUI');

$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created By');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised By');

$structure['main']['fields'][] = array('selected' => 'Selected');

?>