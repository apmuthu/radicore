<?php
//*****************************************************************************
// Extract the contents of a database table and export them to a PDF file which
// will be downloaded to the client device.
//*****************************************************************************

$table_id = 'mnu_subsystem';                   // table name
$report   = 'mnu_subsystem.list.report.inc';   // file identifying report structure

// customise the SQL SELECT statement
$sql_select  = 'mnu_subsystem.subsys_id, subsys_desc, subsys_dir, task_prefix, count(task_id) as count';
$sql_from    = 'mnu_subsystem LEFT JOIN mnu_task ON (mnu_task.subsys_id=mnu_subsystem.subsys_id) ';
$sql_where   = null;
$sql_groupby = 'mnu_subsystem.subsys_id, subsys_desc, subsys_dir, task_prefix';
$sql_having  = null;
$sql_orderby = null;

require 'std.output2.inc';      // activate page controller

?>
