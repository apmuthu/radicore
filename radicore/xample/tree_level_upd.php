<?php
//*****************************************************************************
// This will allow an occurrences of the TREE_LEVEL table to be updated.
// The identity of the selected occurrence is passed down from the previous screen.
//*****************************************************************************

//DebugBreak();
$table_id = 'x_tree_level';            	    // table id
$screen   = 'tree_level.detail.screen.inc'; // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = '';
$sql_from   = '';
$sql_where  = '';

require 'std.update1.inc';                  // activate page controller

?>
