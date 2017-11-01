<?php
//*****************************************************************************
// List the contents of the TREE_TYPE table and allow the user to view/modify
// the contents by activating other screens via navigation buttons. 
//*****************************************************************************

//DebugBreak();
$table_id = 'x_tree_type';        	        // table name
$screen   = 'tree_type.list.screen.inc';    // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = NULL;
$sql_from   = NULL;
$sql_where  = NULL;

// set default sort sequence
$sql_orderby = NULL;

require 'std.list1.inc';                    // activate page controller

?>
