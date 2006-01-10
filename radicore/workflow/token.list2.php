<?php
//*****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons. 
//*****************************************************************************

//DebugBreak();
$outer_table = 'wf_case';               // name of outer table
$inner_table = 'wf_token';            	// name of inner table
$screen   = 'token.list2.screen.inc';   // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = NULL;
$sql_from   = NULL;
$sql_where  = NULL;

// set default sort sequence
$sql_orderby = 'token_id';

// activate page controller
require 'std.list2.inc';

?>
