<?php
//*****************************************************************************
// List the contents of the INNER table for a particular ID rom the OUTER table
// (as selected in the previous screen) and allow the user to view/modify
// the contents by activating other screens via navigation buttons. 
//*****************************************************************************

//DebugBreak();
$outer_table = 'mnu_role';                  // name of outer table
$inner_table = 'mnu_user';                  // name of inner table
$screen   = 'mnu_user.list2.screen.inc';    // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = '';
$outer_sql_from   = '';
$outer_sql_where  = NULL;

$inner_sql_select = NULL;
$inner_sql_from   = NULL;
$inner_sql_where  = NULL;

// set default sort sequence
$inner_sql_orderby = NULL;

// activate page controller
require 'std.list2.inc';

?>
