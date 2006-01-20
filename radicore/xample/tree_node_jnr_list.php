<?php
//*****************************************************************************
// List the contents of the TREE_NODE table for a particular value of NODE_ID_SNR
// (as selected in the previous screen) and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

//DebugBreak();
$outer_table = 'x_tree_node_snr_s01';           // name of outer table
$inner_table = 'x_tree_node_jnr_s02';           // name of inner table
$screen   = 'tree_node_jnr.list.screen.inc';    // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = NULL;
$outer_sql_from   = NULL;
$outer_sql_where  = NULL;

$inner_sql_select = NULL;
$inner_sql_from   = NULL;
$inner_sql_where  = NULL;

// set default sort sequence
$inner_sql_orderby = 'tree_node.node_desc';

require 'std.list2.inc';                        // activate page controller

?>
