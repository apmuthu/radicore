<?php
//*****************************************************************************
// run a script in the background
//*****************************************************************************

$stdout = '../logs/audit_ssn(batch)delete.html';
//$csvout = '../logs/order_item.csv';
//$pdfout = '../logs/order_item.pdf';

ini_set('include_path', '.');
require 'std.batch.inc';

batchInit(__FILE__);

// custom code starts here

$table_id = 'audit_ssn_s01';            // table name
checkFileExists('std.delete3.inc');
$errors = require 'std.delete3.inc';    // activate page controller

// custom code ends here

batchEnd($errors);

?>
