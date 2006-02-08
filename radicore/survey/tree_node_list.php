<?php
//*****************************************************************************
// List the contents of the TREE_NODE table and show the contents as a tree structure.
// Parent nodes will have a button to allow their children to be expanded or collapsed.
//*****************************************************************************

//DebugBreak();
$table_id = 'tree_node';				    // table name
$screen   = 'tree_node.list.screen.inc';    // file identifying screen structure

require 'std.tree_view1.inc';               // activate page controller

?>
