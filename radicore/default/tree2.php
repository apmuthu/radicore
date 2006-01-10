<?php
//*****************************************************************************
// List the contents of the TREE_NODE table for a particular value of TREE_TYPE_ID
// (as selected in the previous screen) and show the contents as a tree structure.
// Parent nodes will have a button to allow their children to be expanded or collapsed. 
//*****************************************************************************

//DebugBreak();
$outer_table = '#outer_table#';					// name of outer table
$inner_table = '#inner_table#';          	    // name of inner table
$screen      = '#inner_table#.list.screen.inc'; // file identifying screen structure

require 'std.tree_view2.inc';           // activate page controller

?>
