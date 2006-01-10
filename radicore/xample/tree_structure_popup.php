<?php
//*****************************************************************************
// List the contents of the TREE_NODE table and allow the user to choose one or
// more occurrences. The identity of those selected will be returned to the
// previous screen. NOTE: This displays nodes in a tree view.
//*****************************************************************************

//DebugBreak();
$outer_table = 'x_tree_type';                   // name of outer table
$inner_table = 'x_tree_node_jnr';               // name of inner table
$screen   = 'tree_structure.list.screen.inc';   // file identifying screen structure

// can only select one entry
$select_one = true;

require 'std.tree_view2.popup.inc';             // activate page controller

?>
