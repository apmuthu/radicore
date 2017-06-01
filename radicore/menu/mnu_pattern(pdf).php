<?php
//*****************************************************************************
// Extract the contents of a database table and export them to a PDF file which
// will be downloaded to the client device.
//*****************************************************************************

$table_id = 'mnu_pattern';                   // table name
$report   = 'mnu_pattern.list.report.inc';   // file identifying report structure

// customise the SQL SELECT statement
$sql_select = 'mnu_pattern.pattern_id, pattern_name, count(task_id) as count, visible_screen, context_preselect, mnu_pattern.keep_data';
$sql_from   = 'mnu_pattern '
            . 'LEFT JOIN mnu_task ON (mnu_task.pattern_id=mnu_pattern.pattern_id) ';
$sql_where   = null;
//$sql_groupby = 'mnu_pattern.pattern_id, pattern_name, visible_screen, context_preselect, mnu_pattern.keep_data';
$sql_groupby = 'mnu_pattern.pattern_id';
$sql_having  = null;
$sql_orderby = null;

require 'std.output2.inc';      // activate page controller

?>
