<?php
//*****************************************************************************
// List the contents of the INNER table for a particular ID rom the OUTER table
// (as selected in the previous screen) and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

$outer_table = 'dict_database';             // name of outer table
$inner_table = 'dict_table';                // name of inner table
$screen   = 'dict_table.list2.screen.inc';  // file identifying screen structure

$inner_sql_select  = 'dict_table.database_id, dict_table.table_id, dict_table.table_desc';
$inner_sql_select .= ', (SELECT COUNT(table_id) FROM dict_column WHERE dict_column.database_id=dict_table.database_id AND dict_column.table_id=dict_table.table_id GROUP BY dict_column.table_id) AS column_count';
$inner_sql_select .= ', (SELECT COUNT(table_id_snr) FROM dict_relationship WHERE dict_relationship.database_id_snr=dict_table.database_id AND dict_relationship.table_id_snr=dict_table.table_id GROUP BY dict_relationship.table_id_snr) AS rel_count_snr';
$inner_sql_select .= ', (SELECT COUNT(table_id_jnr) FROM dict_relationship WHERE dict_relationship.database_id_jnr=dict_table.database_id AND dict_relationship.table_id_jnr=dict_table.table_id GROUP BY dict_relationship.table_id_jnr) AS rel_count_jnr';
$inner_sql_from    = null;
$inner_sql_groupby = null;

require 'std.list2.inc';                    // activate page controller

?>
