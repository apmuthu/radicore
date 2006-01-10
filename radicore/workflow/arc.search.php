<?php
//*****************************************************************************
// Show a blank detail screen for a database table and allow the user to enter
// selection criteria, which will be passed back to the previous screen. 
//*****************************************************************************

//DebugBreak();
$table_id = "wf_arc";                 // table id
$screen   = 'arc.detail.screen.inc';  // file identifying screen structure

// activate page controller
require 'std.search1.inc';

?>
