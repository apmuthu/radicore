<?php
//*****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

$table_id = 'wf_workitem_s01';                       // table name
$screen   = 'workitem.list(expired).screen.inc';     // file identifying screen structure

require 'std.list1.inc';                    // activate page controller

?>
