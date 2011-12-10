<?php
//*****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

$table_id = 'dict_database';    	            // table name
$screen   = 'dict_database.list.screen.inc';    // file identifying screen structure

$sql_select  = 'dict_database.database_id, database_desc, dict_database.subsys_id';
$sql_select .= ', (SELECT COUNT(database_id) FROM dict_table WHERE dict_table.database_id=dict_database.database_id) as table_count';
$sql_select .= ', (SELECT COUNT(database_id_snr) FROM dict_relationship WHERE dict_relationship.database_id_snr=dict_database.database_id) as rel_count';
$sql_from   = null;
$sql_groupby = null;

require 'std.list1.inc';                        // activate page controller

?>
