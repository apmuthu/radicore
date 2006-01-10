<?php
//*****************************************************************************
// This will allow occurrences of a database table to be deleted.
// The identity of the selected occurrence(s) is passed from the previous screen.
//*****************************************************************************

//DebugBreak();
$table_id = 'dict_relationship';             	    // table id
$screen   = 'dict_relationship.detail.screen.inc';  // file identifying screen structure

//$outer_table = 'dict_relationship';				    // name of outer table
//$inner_table = 'dict_related_column';               // name of inner table
//$screen   = 'dict_related_column.list2.screen.inc';  // file identifying screen structure

require 'std.delete1.inc';      // activate page controller
//require 'std.list2.inc';    // activate page controller

?>
