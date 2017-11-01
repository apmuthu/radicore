<?php
//*****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

$outer_table = 'wf_case';               // name of outer table
$inner_table = 'wf_token';            	// name of inner table
$screen   = 'token.list2.screen.inc';   // file identifying screen structure

require 'std.list2.inc';                // activate page controller

?>
