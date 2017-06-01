<?php
//*****************************************************************************
// Extract the contents of a database table and export them to a PDF file which
// will be downloaded to the client device.
//*****************************************************************************

$table_id = 'dict_database';                   // table name
$report   = 'dict_database.list.report.inc';   // file identifying report structure

// customise the SQL SELECT statement
$sql_select  = 'dict_database.database_id, database_name, database_desc';
$sql_select .= ', (SELECT COUNT(database_id) FROM dict_table WHERE dict_table.database_id=dict_database.database_id) as table_count';
$sql_select .= ', (SELECT COUNT(database_id_snr) FROM dict_relationship WHERE dict_relationship.database_id_snr=dict_database.database_id) as rel_count_snr';
$sql_from   = null;
$sql_groupby = null;

require 'std.output2.inc';      // activate page controller

?>
