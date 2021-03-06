<?php
//*****************************************************************************
// List the contents of the TREE_NODE table and allow the user to choose one or
// more occurrences. The identity of those selected will be returned to the
// previous screen.
// NOTE: This will show only orphan nodes (those where NODE_ID_SNR is NULL).
//*****************************************************************************

//DebugBreak();
$outer_table = 'x_tree_level_s02';              // name of outer table
$inner_table = 'x_tree_node_jnr_s01';           // name of inner table
$screen   = 'tree_node_jnr.popup.screen.inc';   // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = NULL;
$outer_sql_from   = NULL;
$outer_sql_where  = NULL;

$inner_sql_select = NULL;
$inner_sql_from   = NULL;
$inner_sql_where  = NULL;

// set default sort sequence
$inner_sql_orderby = 'x_tree_node.node_desc';

require 'std.list2.popup.inc';                  // activate page controller

?>
