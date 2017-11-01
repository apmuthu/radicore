<?php
//*****************************************************************************
// This will allow occurrences of the INNER table to be displayed and modified.
// This version starts by showing the exiting entries, then allows the user
// to add, delete or modify entries.
// The identity of the OUTER table is passed down from the previous screen.
//*****************************************************************************

$outer_table = 'mnu_task_snr';			     // name of outer table
$inner_table = 'mnu_menu';                   // name of inner table
$screen      = 'mnu_menu.list2.screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = 'task_id, task_name, task_type';
$outer_sql_from   = NULL;
$outer_sql_where  = NULL;

$inner_sql_select = '';
$inner_sql_from   = '';
$inner_sql_where  = '';

// set default sort sequence
$inner_sql_orderby = 'sort_seq';

require 'std.list2.inc';                    // activate page controller

?>
