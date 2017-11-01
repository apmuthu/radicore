<?php
//*****************************************************************************
// This will allow a single occurrences of a database table to be updated.
// The identity of the selected occurrence is passed down from the previous screen.
//*****************************************************************************

$table_id = 'mnu_task_ip_address';                      // table id
$screen   = 'mnu_task_ip_address.detail.screen.inc';    // file identifying screen structure

// customise the SQL SELECT statement
$sql_select  = null;
$sql_from    = null;
$sql_where   = null;
$sql_groupby = null;
$sql_having  = null;

require 'std.update1.inc';          // activate page controller

?>
