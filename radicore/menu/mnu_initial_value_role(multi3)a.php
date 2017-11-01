<?php
//*****************************************************************************
// This is for a PARENT-CHILD-GRANDCHILD relationship (ONE-to-MANY-to-MANY).
// An occurrence of the PARENT (outer) is selected using values passed down from the
// previous form. One or more associated occurrences are then read from the
// CHILD (middle), followed by multiple entries from the GRANDCHILD (inner).
// Entries from the GRANDCHILD may be inserted, amended or deleted.
// Only a single occurrence of the PARENT and CHILD will be shown at any one
// time, but scrolling areas will be shown if more occurrences are available.
//*****************************************************************************

$outer_table  = 'mnu_task';				                 // name of outer table
$middle_table = 'mnu_role_s01';                          // name of middle table
$inner_table  = 'mnu_initial_value_role_s01';                 // name of inner table
$screen       = 'mnu_initial_value_role.multi3a.screen.inc';  // file identifying screen structure

// customise the SQL SELECT statement
$outer_sql_select  = 'task_id, task_name, task_type';
$outer_sql_from    = 'mnu_task';
$outer_sql_where   = "EXISTS(SELECT 1 FROM mnu_task_field WHERE task_id=mnu_task.task_id AND is_documentation_only='N')";
$outer_sql_groupby = null;
$outer_sql_having  = null;
$outer_sql_orderby = null;
$outer_sql_orderby_table = null;

$middle_sql_select  = 'mnu_role.role_id, role_name, global_access';
$middle_sql_from    = 'mnu_role';
$middle_sql_where   = null;
$middle_sql_groupby = null;
$middle_sql_having  = null;
$middle_sql_orderby = null;

$inner_sql_select   = null;
$inner_sql_from     = null;
$inner_sql_where    = "mnu_task_field.is_documentation_only='N'";
$inner_sql_groupby  = null;
$inner_sql_having   = null;
$inner_sql_orderby  = 'mnu_task_field.field_id';
$inner_search_table = null;

require 'std.multi3.inc';                       // activate page controller

?>
