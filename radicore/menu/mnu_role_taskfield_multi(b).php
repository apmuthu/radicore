<?php
//*****************************************************************************
// This will allow occurrences of the INNER table to be displayed and
// modified. This version starts by showing the exiting entries, then allows the
// user to add, delete or modify entries.
// The id of the OUTER entty is passed down from the previous screen.
// The MIDDLE entity is scanned one entry at a time.
// The INNER entity is identified using the id from the OUTER and MIDDLE entities.
//*****************************************************************************

//DebugBreak();
$outer_table  = 'mnu_role';                             // name of outer table
$middle_table = 'mnu_task_s01';                         // name of middle table
$inner_table  = 'mnu_role_taskfield_s01';               // name of table to be amended
$screen = 'mnu_role_taskfield.multi(b).screen.inc';     // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = 'role_id, role_desc';
$outer_sql_from   = NULL;
$outer_sql_where  = NULL;

$middle_sql_select = 'mnu_task.task_id,task_desc';
$middle_sql_from   = 'mnu_task, mnu_task_field ';
$middle_sql_where  = 'mnu_task_field.task_id=mnu_task.task_id';
$middle_sql_groupby = 'mnu_task.task_id, task_desc';

$inner_sql_select = '';
$inner_sql_from   = '';
$inner_sql_where  = '';

// activate page controller
require 'std.multi3.inc';

?>
