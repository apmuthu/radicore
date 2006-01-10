<?php
//*****************************************************************************
// List the contents of the TREE_LEVEL table and allow the user to view/modify
// the contents by activating other screens via navigation buttons. 
//*****************************************************************************

//DebugBreak();
$outer_table = 'x_tree_type';				// name of outer table
$inner_table = 'x_tree_level';            	// name of inner table
$screen   = 'tree_level.list.screen.inc';   // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = NULL;
$outer_sql_from   = NULL;
$outer_sql_where  = NULL;

$inner_sql_select = '';
$inner_sql_from   = '';
$inner_sql_where  = '';

// set default sort sequence
$inner_sql_orderby = '';

require 'std.list2.inc';                    // activate page controller

?>
