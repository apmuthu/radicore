<?php
//*****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

$table_id = 'wf_workitem';                  // table name
$screen   = 'workitem.list.screen.inc';     // file identifying screen structure

require 'std.list1.inc';                    // activate page controller

?>
