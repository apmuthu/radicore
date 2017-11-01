<?php
//*****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

$table_id = 'dict_table';                   // name of inner table
$screen   = 'dict_table.list1.screen.inc';  // file identifying screen structure

$sql_select = 'dict_table.database_id, dict_table.table_id, dict_table.table_name';
$sql_select .= ', (SELECT COUNT(table_id) FROM dict_column WHERE dict_column.database_id=dict_table.database_id AND dict_column.table_id=dict_table.table_id GROUP BY dict_column.table_id) AS column_count';
$sql_select .= ', (SELECT COUNT(table_id_snr) FROM dict_relationship WHERE dict_relationship.database_id_snr=dict_table.database_id AND dict_relationship.table_id_snr=dict_table.table_id GROUP BY dict_relationship.table_id_snr) AS rel_count_snr';
$sql_select .= ', (SELECT COUNT(table_id_jnr) FROM dict_relationship WHERE dict_relationship.database_id_jnr=dict_table.database_id AND dict_relationship.table_id_jnr=dict_table.table_id GROUP BY dict_relationship.table_id_jnr) AS rel_count_jnr';
$sql_from   = null;
$sql_groupby = null;

require 'std.list1.inc';                    // activate page controller

?>
