<?php
//*****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons. 
//*****************************************************************************

//DebugBreak();
$table_id = 'dict_database';    	            // table name
$screen   = 'dict_database.list.screen.inc';    // file identifying screen structure

// activate page controller
require 'std.list1.inc';

?>
