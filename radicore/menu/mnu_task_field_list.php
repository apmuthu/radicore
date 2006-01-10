<?php
//*****************************************************************************
// List the contents of the INNER table for a particular ID on the OUTER table
// (as selected in the previous screen) and allow the user to view/modify
// the contents by activating other screens via navigation buttons. 
//*****************************************************************************

//DebugBreak();
$outer_table = 'mnu_task';                   // name of outer table
$inner_table = 'mnu_task_field';             // name of inner table
$screen = 'mnu_task_field.list.screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = NULL;
$outer_sql_from   = NULL;
$outer_sql_where  = NULL;

$inner_sql_select = NULL;
$inner_sql_from   = NULL;
$inner_sql_where  = NULL;

// set default sort sequence
$inner_sql_orderby = NULL;

// activate page controller
require 'std.list2.inc';

?>
