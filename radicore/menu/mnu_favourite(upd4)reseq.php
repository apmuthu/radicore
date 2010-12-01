<?php
//*****************************************************************************
// Allow new occurrences to be added to a database table (without user dialog).
// Optional selection criteria may be passed down from the previous screen.
// This uses the updateMultiple() method.
//*****************************************************************************

$table_id = 'mnu_favourite_s03';       // table name

// customise the SQL SELECT statement
$sql_select  = null;
$sql_from    = null;
$sql_where   = null;
$sql_groupby = null;
$sql_having  = null;

require 'std.update4.inc';      // activate page controller

?>
