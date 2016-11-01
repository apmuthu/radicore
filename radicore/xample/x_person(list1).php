<?php
//*****************************************************************************
// List the contents of the PERSON table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

$table_id = 'x_person';            	   // table name
$screen   = 'person.list.screen.inc';  // file identifying screen structure

// customise the SQL SELECT statement
$sql_select  = 'person_id, first_name, last_name, star_sign, pers_type_id';
$sql_from    = null;
$sql_where   = null;
$sql_groupby = null;
$sql_having  = null;
$sql_orderby = null;

require 'std.list1.inc';               // activate page controller

?>
