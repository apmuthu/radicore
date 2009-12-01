<?php
//*****************************************************************************
// This will allow occurrences of the INNER table to be displayed and
// modified. This version starts by showing the exiting entries, then allows the
// user to add, delete or modify entries.
// The id of the OUTER entty is passed down from the previous screen.
// The MIDDLE entity is scanned one entry at a time.
// The INNER entity is identified using the id from the OUTER and MIDDLE entities.
//*****************************************************************************

$outer_table  = 'mnu_role';                             // name of outer table
$middle_table = 'mnu_task_s01';                         // name of middle table
$inner_table  = 'mnu_role_taskfield_s01';               // name of table to be amended
$screen = 'mnu_role_taskfield.multi(b).screen.inc';     // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = 'role_id, role_desc, global_access';
$outer_sql_from   = 'mnu_role LEFT JOIN mnu_task ON (mnu_task.task_id=mnu_role.start_task_id)';
$outer_sql_where  = NULL;
//$outer_sql_groupby = 'mnu_role.role_id, role_desc, global_access';
$outer_sql_groupby = 'mnu_role.role_id';
$outer_sql_having = "global_access='N'";

$middle_sql_select = 'mnu_task.task_id,task_desc';
$middle_sql_from   = 'mnu_task LEFT JOIN mnu_task_field ON (mnu_task_field.task_id=mnu_task.task_id) ';
$middle_sql_where  = 'mnu_task_field.task_id=mnu_task.task_id';
//$middle_sql_groupby = 'mnu_task.task_id, task_desc';
$middle_sql_groupby = 'mnu_task.task_id';

$inner_sql_select = '';
$inner_sql_from   = '';
$inner_sql_where  = '';
$inner_sql_orderby = 'mnu_task_field.field_id';

require 'std.multi3.inc';                               // activate page controller

?>
