<?php
//*****************************************************************************
// Extract the contents of a database table and export them to a PDF file which
// will be downloaded to the client device.
//*****************************************************************************

$table_id = 'x_person_s04';                  // table name
$report   = 'x_invoice.detail.report.inc';   // file identifying report structure

require 'std.output3.inc';      // activate page controller

?>
