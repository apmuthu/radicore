<?php
//*****************************************************************************
// This will allow an occurrences of a database table to be deleted.
// The identity of the selected occurrence is passed down from the previous screen.
//*****************************************************************************

//DebugBreak();
$table_id = 'tree_node';				    // table name
$screen   = 'tree_node.detail.screen.inc';  // file identifying screen structure

// activate page controller
require 'std.delete1.inc';

?>
