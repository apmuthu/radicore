<?php

// this changes column_desc from 'abc_xyz' to 'Abc Xyz'

ini_set('include_path', '.');
require 'std.batch.inc';

batchInit(__FILE__);

// create objects for each database table
require 'classes/dict_column.class.inc';
$dbobject = new dict_column;

$dbobject->sql_select = 'database_id, table_id, column_id, column_desc';
$dbobject->sql_from   = '';
$dbobject->sql_groupby = '';
$dbresult = $dbobject->getData_batch('column_desc LIKE BINARY column_id');
$dbobject->startTransaction();
while ($row = $dbobject->fetchRow($dbresult)) {
    $row['column_desc'] = ucwords(str_replace('_', ' ', $row['column_id']));
    echo '<p>Updated ' .$row['database_id'] .'.' .$row['table_id'] .'.' .$row['column_id'] .'</p>' ."\n";
	//$dbobject->startTransaction();
	$dbobject->skip_validation = true;
	$row = $dbobject->updateRecord($row);
	check_errors($dbobject);
	//$dbobject->commit();
} // while

$dbobject->commit();

batchEnd();

?>
