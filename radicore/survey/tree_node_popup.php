<?php
//*****************************************************************************
// List the contents of the TREE_NODE table and show the contents as a tree structure.
// This version will ask the user to choose a LOCATION.
//*****************************************************************************

$table_id = 'tree_node';				    // table name
$screen   = 'tree_node.list.screen.inc';    // file identifying screen structure

$message[] = 'Please choose a LOCATION';

require 'std.tree_view1.popup.inc';         // activate page controller

?>
