<?php

// this checks that person.last_addr_no = count(person_addr.person_id)

ini_set('include_path', '.');
require 'std.batch.inc';

batchInit(__FILE__);

// create objects for each database table
require 'classes/x_person.class.inc';
$dbobject = new x_person;

$dbobject->sql_select = 'x_person.person_id, x_person.last_addr_no, count(address_no) as count';
$dbobject->sql_from   = 'x_person LEFT JOIN x_person_addr ON (x_person_addr.person_id=x_person.person_id)';
$dbobject->sql_groupby = 'x_person.person_id, x_person.last_addr_no';
$dbresult = $dbobject->getData_serial();
$dbobject->startTransaction();
while ($row = $dbobject->fetchRow($dbresult)) {
    if ($row['last_addr_no'] <> $row['count']) {
    	$row['last_addr_no'] = $row['count'];
    	echo '<p>Updated person_id ' .$row['person_id'] .', last_addr_no=' .$row['count'] .'</p>';
    	//$dbobject->startTransaction();
    	$dbobject->skip_validation = true;
    	$row = $dbobject->updateRecord($row);
    	check_errors($dbobject);
    	//$dbobject->commit();
    } // if
} // while

$dbobject->commit();

batchEnd();

?>
