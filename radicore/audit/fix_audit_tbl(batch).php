<?php

// this removes unwanted spaces from audit_tbl.pkey

$stdout = '../logs/fix_audit_tbl.html';

ini_set('include_path', '.');
require 'std.batch.inc';

batchInit(__FILE__);

$dbobject = RDCsingleton::getInstance('audit_tbl');

$dbresult = $dbobject->getData_serial("pkey REGEXP ' =\''");
$count1 = $dbobject->getNumRows();
echo "<p>$count1 records found</p>\n";

$dbobject->startTransaction();
$count2  = 0;
$count3  = $count1;
$modulus = 100;
while ($row = $dbobject->fetchRow($dbresult)) {
    $where_array = where2array($row['pkey']);
    $where       = array2where($where_array);
    $row['pkey'] = $where;
   	$row = $dbobject->updateRecord($row);
    check_errors($dbobject);
    $count2++;
    if ($count2 % $modulus == 0) {
        $count3 = $count3 - $modulus;
        echo "<p>$count2 records processed, $count3 records remaining</p>\n";
        $dbobject->commit();
        $dbobject->startTransaction();
    } // if
} // while

$dbobject->commit();

echo "<p>$count1 records updated</p>\n";

batchEnd();

?>
