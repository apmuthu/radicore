<?php
//*****************************************************************************
// This will allow an occurrences of the PERSON table to be updated.
// The identity of the selected occurrence is passed down from the previous screen.
//*****************************************************************************

$table_id = 'x_person_s03';               // table id
$screen   = 'person.detail(fckeditor).screen.inc';   // file identifying screen structure

// customise the SQL SELECT statement
$sql_select  = 'person_id, fckeditor_test';
$sql_from    = null;
$sql_where   = null;
$sql_groupby = null;
$sql_having  = null;

require 'std.update1.inc';                // activate page controller

?>
