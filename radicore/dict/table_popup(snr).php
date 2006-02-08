<?php
//*****************************************************************************
// List the contents of the INNER table for a particular ID rom the OUTER table
// (as selected in the previous screen) and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

$outer_table = 'dict_database';             // name of outer table
$inner_table = 'dict_table';                // name of inner table
$screen   = 'dict_table.list2.screen.inc';  // file identifying screen structure

$inner_sql_select = 'dict_table.*, count(dict_column.table_id) as column_count';
$inner_sql_from   = 'dict_table '
                   .'LEFT JOIN dict_column ON (dict_table.database_id=dict_column.database_id AND dict_table.table_id=dict_column.table_id) ';
$inner_sql_groupby = 'dict_table.table_id';

require 'std.list2.popup.inc';              // activate page controller

?>
