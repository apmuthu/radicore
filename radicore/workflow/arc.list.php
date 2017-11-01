<?php
//*****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

$outer_table = 'wf_workflow';       // name of outer table
$inner_table = 'wf_arc';          	// name of inner table
$screen   = 'arc.list.screen.inc';  // file identifying screen structure

$inner_sql_orderby = 'place_type';

require 'std.list2.inc';            // activate page controller

?>
