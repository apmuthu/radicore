<?php
// *****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
// *****************************************************************************

$table_id = 'mnu_pattern';                  // table name
$screen = 'mnu_pattern.list1.screen.inc';   // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = 'pattern_id, pattern_desc';
$sql_select .= ", (SELECT COUNT(task_id) FROM mnu_task WHERE mnu_task.pattern_id=mnu_pattern.pattern_id) AS task_count";
$sql_from   = 'mnu_pattern ';
$sql_where  = null;
//$sql_groupby = 'mnu_pattern.pattern_id, pattern_desc';
$sql_groupby = '';

// set default sort sequence
$sql_orderby = null;

require 'std.list1.inc';                        // activate page controller

?>
