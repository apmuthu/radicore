<?php
//*****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons. 
//*****************************************************************************

//DebugBreak();
$table_id = 'wf_workitem';                 // table name
$screen   = 'workitem.list.screen.inc';    // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = NULL;
$sql_from   = NULL;
$sql_where  = NULL;

// set default sort sequence
$sql_orderby = 'case_id, workitem_id';

// activate page controller
require 'std.list1.inc';

?>
