<?php
//*****************************************************************************
// This will allow an occurrences of the LINK table to be added or deleted.
// The identity of the OUTER occurrence is passed down from the previous screen.
// The INNER table is defined using LEFT JOIN from within the LINK table.
// The existence of individual LINK table entries will be shown in a checkbox
// which can be toggled ON to create a record or OFF to delete a record.
//*****************************************************************************

$outer_table = 'mnu_task';      				// name of outer table
$link_table  = 'mnu_role_task';       	        // name of link table
$inner_table = 'mnu_role';                      // name of inner table
$screen = 'mnu_role_task.link1(a).screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = 'mnu_task.task_id, mnu_task.task_desc';
$outer_sql_from   = NULL;
$outer_sql_where  = NULL;

// modify the sql select for the LINK table
$link_sql_select = '';
$link_sql_from   = '';
$link_sql_where  = '';
$link_sql_orderby = '';
$link_sql_orderby_table = 'mnu_role';
$link_search_table      = 'mnu_role';

require 'std.link1.inc';                        // activate page controller

?>
