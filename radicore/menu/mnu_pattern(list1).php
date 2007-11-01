<?php
// *****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
// *****************************************************************************

$table_id = 'mnu_pattern';                  // table name
$screen = 'mnu_pattern.list1.screen.inc';   // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = 'mnu_pattern.pattern_id, pattern_desc, count(task_id) as count';
$sql_from   = 'mnu_pattern '
            . 'LEFT JOIN mnu_task ON (mnu_task.pattern_id=mnu_pattern.pattern_id) ';
$sql_where  = null;
$sql_groupby = 'mnu_pattern.pattern_id, pattern_desc';

// set default sort sequence
$sql_orderby = null;

require 'std.list1.inc';                        // activate page controller

?>
