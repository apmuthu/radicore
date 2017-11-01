<?php
//*****************************************************************************
// this uploads data from a CSV file to the XAMPLE database
//*****************************************************************************

$stdout = '../logs/person_csv.html';

ini_set('include_path', '.');
require 'std.batch.inc';

batchInit(__FILE__);

$task_id = basename($task_id, '.php');
$role_id = 'DEMO';

$filename = 'files/upload/person.csv';

$dbobject = RDCsingleton::getInstance('x_person');

// do not fail if record already exists when inserting
$dbobject->no_duplicate_error = TRUE;

require('std.csv.class.inc');
$CSVobj = new csv_class($dbobject);

// read first line to obtain delimiter (comma, tab or pipe)
$CSVobj->open_read($filename);
check_errors($CSVobj);

$count = 0;
while ($data = $CSVobj->read_file()) {
	// give this array to the database object
	$dbobject->startTransaction();
    $data = $dbobject->insertRecord($data);
    check_errors($dbobject);
    $dbobject->commit();
    $count ++;
    $key = 'person_id= ' .$data['person_id'];
    if ($dbobject->numrows == 0) {
    	$output = "<p>$count : $key already exists</p>\r\n";
    } else {
        $output = "<p>$count : $key created</p>\r\n";
    } // if
    if (!$result = fwrite($stdouth, $output)) {
        trigger_error("Cannot write to file $stdout", E_USER_ERROR);
    } // if
    $output = '';
} // while
check_errors($CSVobj);

$output = "<p>$count records processed.<p>";
if (!$result = fwrite($stdouth, $output)) {
    trigger_error("Cannot write to file $stdout", E_USER_ERROR);
} // if

fclose($handle);

batchEnd();

?>
