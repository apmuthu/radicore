<?php 
// *****************************************************************************
// List the contents of the INNER table for a particular ID from the OUTER table
// (as selected in the previous screen) and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
// *****************************************************************************

//DebugBreak();
$outer_table = 'mnu_subsystem';             // name of outer table
$inner_table = 'mnu_task';                  // name of inner table
$screen = 'mnu_task.list3.screen.inc';      // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = '';
$outer_sql_from   = '';
$outer_sql_where  = null;

$inner_sql_select = null;
$inner_sql_from   = null;
$inner_sql_where  = null;

// set default sort sequence
$inner_sql_orderby = null;

// activate page controller
require 'std.list2.inc';

?>
