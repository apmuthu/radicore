<?php
//*****************************************************************************
// This will allow occurrences of a database table to be deleted.
// This will include ALL related occurrences on ALL child tables, thus bypassing
// any delete constraints which may have been set to RESTRICTED or NULLIFY.
// The identity of the selected occurrence(s) is passed from the previous screen.
//*****************************************************************************

$table_id = '#tablename#';             	        // table id
$screen   = '#tablename#.erase1.screen.inc';    // file identifying screen structure

// customise the SQL SELECT statement
$sql_select  = null;
$sql_from    = null;
$sql_where   = null;
$sql_groupby = null;
$sql_having  = null;

require 'std.erase1.inc';          // activate page controller

?>
