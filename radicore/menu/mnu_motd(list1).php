<?php
// *****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
// *****************************************************************************

$table_id = 'mnu_motd';                      // table name
$screen   = 'mnu_motd.list1.screen.inc';     // file identifying screen structure

// customise the SQL SELECT statement
$sql_select  = null;
$sql_from    = null;
$sql_where   = null;
$sql_groupby = null;
$sql_having  = null;
$sql_orderby = null;
$sql_search_table = null;

require 'std.list1.inc';            // activate page controller

?>
