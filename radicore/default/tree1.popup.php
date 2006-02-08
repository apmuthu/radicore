<?php
//*****************************************************************************
// List the contents of the TREE_NODE table and show the contents as a tree structure.
// Parent nodes will have a button to allow their children to be expanded or collapsed.
// This will allow the user to select and entry by means of a CHOOSE button.
//*****************************************************************************

$outer_table = '#outer_table#';                     // name of outer table
$inner_table = '#inner_table#';                     // name of inner table
$screen      = '#inner_table#.tree1.screen.inc';    // file identifying screen structure

// customise the SQL SELECT statement
$sql_select  = null;
$sql_from    = null;
$sql_where   = null;
$sql_groupby = null;
$sql_having  = null;

require 'std.tree_view1.popup.inc';                 // activate page controller

?>
