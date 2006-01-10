<?php
//*****************************************************************************
// This will allow an occurrences of the TREE_NODE table to be displayed in detail.
// The identity of the selected occurrence is passed down from the previous screen.
//*****************************************************************************

//DebugBreak();
$table_id = 'x_tree_node';				 	// table id
$screen   = 'tree_node.detail.screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = '';
$sql_from   = '';
$sql_where  = '';

require 'std.enquire1.inc';                 // activate page controller

?>
