<?php
//*****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

$table_id = 'dict_table';                   // name of inner table
$screen   = 'dict_table.list.screen.inc';   // file identifying screen structure

$sql_select = 'dict_table.database_id, dict_table.table_id, dict_table.table_desc';
$sql_from   = null;
$sql_groupby = null;

require 'std.list1.inc';                    // activate page controller

?>
