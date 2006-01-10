<?php
//*****************************************************************************
// Show a blank detail screen for a database table and allow the user to enter
// selection criteria, which will be passed back to the previous screen. 
//*****************************************************************************

//DebugBreak();
$table_id = 'mnu_todo';                    // table id
$screen   = 'mnu_todo.detail.screen.inc';  // file identifying screen structure

require 'std.search1.inc';          // activate page controller

?>
