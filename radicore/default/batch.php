<?php
//*****************************************************************************
// run a script in the background
//*****************************************************************************

$stdout = '../logs/#tablename#.html';
$csvout = '../logs/#tablename#.csv';
$pdfout = '../logs/#tablename#.pdf';

ini_set('include_path', '.');
require 'std.batch.inc';

batchInit(__FILE__);

// custom code starts here

// custom code ends here

batchEnd();

?>
