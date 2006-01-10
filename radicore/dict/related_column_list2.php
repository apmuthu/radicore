<?php
//*****************************************************************************
// List the contents of the INNER table for a particular ID rom the OUTER table
// (as selected in the previous screen) and allow the user to view/modify
// the contents by activating other screens via navigation buttons. 
//*****************************************************************************

//DebugBreak();
$outer_table = 'dict_relationship';				    // name of outer table
$inner_table = 'dict_related_column';               // name of inner table
$screen   = 'dict_related_column.list2.screen.inc'; // file identifying screen structure

$inner_sql_select = '';
$inner_sql_from   = '';
$inner_sql_groupby = '';

require 'std.list2.inc';    // activate page controller

?>
