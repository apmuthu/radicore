<?php
//*****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

$table_id = 'risk_status';    	            // table name
$screen   = 'risk_status.list.screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = NULL;
$sql_from   = NULL;
$sql_where  = NULL;
$sql_orderby = NULL;

require 'std.list1.inc';        // activate page controller

?>
