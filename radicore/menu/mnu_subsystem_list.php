<?php
//*****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons. 
//*****************************************************************************

//DebugBreak();
$table_id = 'mnu_subsystem';    	            // table name
$screen   = 'mnu_subsystem.list.screen.inc';    // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = 'mnu_subsystem.subsys_id, mnu_subsystem.subsys_desc, count(task_id) as count';
$sql_from   = 'mnu_subsystem '.
              'LEFT JOIN mnu_task USING (subsys_id) ';
$sql_where  = NULL;
$sql_groupby = 'mnu_subsystem.subsys_id, mnu_subsystem.subsys_desc';

// set default sort sequence
$sql_orderby = NULL;

// activate page controller
require 'std.list1.inc';

?>
