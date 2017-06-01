<?php
//*****************************************************************************
// This will allow an occurrences of the LINK table to be added or deleted.
// The identity of the OUTER occurrence is passed down from the previous screen.
// The INNER table is defined using LEFT JOIN from within the LINK table.
// The existence of individual LINK table entries will be shown in a checkbox
// which can be toggled ON to create a record or OFF to delete a record.
//*****************************************************************************

$outer_table = 'mnu_role';      			    // name of outer table
$link_table  = 'mnu_role_task';       	        // name of link table
$inner_table = 'mnu_task';                      // name of inner table
$screen = 'mnu_role_task.link1(b).screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = 'mnu_role.role_id, mnu_role.role_name';
$outer_sql_from   = NULL;
$outer_sql_where  = NULL;

// modify the sql select for the LINK table
$link_sql_select = '';
$link_sql_from   = '';
$link_sql_where  = '';
$link_sql_orderby = '';
$link_sql_orderby_table = 'mnu_task';
$link_search_table      = 'mnu_task';

require 'std.link1.inc';                        // activate page controller

?>
