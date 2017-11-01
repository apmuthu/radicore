<?php
// *****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
// *****************************************************************************

$table_id = 'audit_logon_errors';                      // table name
$screen   = 'audit_logon_errors.list1.screen.inc';     // file identifying screen structure

// customise the SQL SELECT statement
$sql_select  = null;
$sql_from    = null;
$sql_where   = null;
$sql_groupby = null;
$sql_having  = null;
$sql_orderby = null;

require 'std.list1.inc';            // activate page controller

?>
