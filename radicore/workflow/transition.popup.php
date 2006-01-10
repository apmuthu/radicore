<?php
//*****************************************************************************
// List the contents of a database table and allow the user to choose one or
// more occurrences. The identity of those selected will be returned to the
// previous screen.
//*****************************************************************************

//DebugBreak();
$table_id = 'wf_transition';                 // table name
$screen   = 'transition.list.screen.inc';    // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = NULL;
$sql_from   = NULL;
$sql_where  = NULL;

// set default sort sequence
$sql_orderby = NULL;

require 'std.list1.popup.inc';              // activate page controller

?>
