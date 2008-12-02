<?php
// *****************************************************************************
// Delete and rebuild the contents of the CRS_CONFLICT table.
// *****************************************************************************

$stdout = '../logs/conflict_reset.html';

ini_set('include_path', '.');
require 'std.batch.inc';

batchInit(__FILE__);

$dbobject =& singleton::getInstance('crs_conflict_s01');

echo "<p>Deleting old data</p>\n";

$fieldarray = $dbobject->getInitialDataMultiple('');
check_errors($dbobject);

echo "<p>Inserting new data</p>\n";

$dbobject->startTransaction();
$fieldarray = $dbobject->insertMultiple($fieldarray);
check_errors($dbobject);

$dbobject->commit();

$messages = $dbobject->messages;
echo "<p>$messages[0]</p>\n";

batchEnd();

?>
