<?php
//*****************************************************************************
// This will allow occurrences of the TREE_LEVEL table to be displayed and modified.
// This version allows only the TREE_LEVEL_SEQ to be modified.
// The TREE_TYPE identity is passed down from the previous screen.
//*****************************************************************************

//DebugBreak();
$outer_table = 'x_tree_type';               // name of outer table
$inner_table = 'x_tree_level_s01';          // name of inner table
$screen   = 'tree_level.multi.screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = NULL;
$outer_sql_from   = NULL;
$outer_sql_where  = NULL;

$inner_sql_select = NULL;
$inner_sql_from   = NULL;
$inner_sql_where  = NULL;

// set default sort sequence
$inner_sql_orderby = NULL;

require 'std.multi2.inc';                   // activate page controller

?>
