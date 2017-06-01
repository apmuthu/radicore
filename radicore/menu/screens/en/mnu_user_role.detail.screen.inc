<?php
$structure['xsl_file'] = 'std.detail1.xsl';

$structure['tables']['main'] = 'mnu_user_role';

// identify the column specs - may use 'width' or 'class'
$structure['main']['columns'][] = array('width' => '25%');
$structure['main']['columns'][] = array('width' => '*');

// identify the contents of each row in the table (two formats are allowed)
// the SHORT format defines two cells per row, a label followed by a field, as in:
$structure['main']['fields'][] = array('user_id' => 'User Id');
$structure['main']['fields'][] = array('user_name' => 'User Name');
$structure['main']['fields'][] = array('role_id' => 'Role Id');
$structure['main']['fields'][] = array('role_name' => 'Role Name');
$structure['main']['fields'][] = array('is_primary' => 'Is Primary?');
$structure['main']['fields'][] = array('start_task_id' => 'Start Task Id');
$structure['main']['fields'][] = array('start_task_name' => 'Start Task Name');
$structure['main']['fields'][] = array('is_external_auth_off' => 'External Authorisation Off?');
$structure['main']['fields'][] = array('created_date' => 'Created Date');
$structure['main']['fields'][] = array('created_user' => 'Created User');
$structure['main']['fields'][] = array('revised_date' => 'Revised Date');
$structure['main']['fields'][] = array('revised_user' => 'Revised User');

// the LONG format defines more than two cells in the row, as in:

// it is possible to have a field without a label, but not a label without a field

// all other rows in the table should span the same number of columns (cells), so ...
// any cell can be expanded beyond its default of 1 by adding the COLSPAN keyword

?>