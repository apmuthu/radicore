<?php
//*****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons. 
//*****************************************************************************

//DebugBreak();
$outer_table = 'wf_workflow';       // name of outer table
$inner_table = 'wf_arc';          	// name of inner table
$screen   = 'arc.list.screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$inner_sql_select = NULL;
$inner_sql_from   = NULL;
$inner_sql_where  = NULL;

// activate page controller
require 'std.list2.inc';

?>
