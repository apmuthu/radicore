<?php
//*****************************************************************************
// Show a blank detail screen for a database table and allow the user to enter
// selection criteria, which will be passed back to the previous screen. 
//*****************************************************************************

//DebugBreak();
$table_id = 'x_tree_type';                  // table id
$screen   = 'tree_type.detail.screen.inc';  // file identifying screen structure

require 'std.search1.inc';                  // activate page controller

?>
