<?php
//*****************************************************************************
// List the contents of the PERSON table and allow the user to choose one or
// more occurrences. The identity of those selected will be returned to the
// previous screen.
//*****************************************************************************

//DebugBreak();
$table_id = 'x_person';                // table name
$screen   = 'person.list.screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = '*';
$sql_from   = 'x_person '.
              'LEFT JOIN x_pers_type ON (x_pers_type.pers_type_id=x_person.pers_type_id)';
$sql_where  = '';

// set default sort sequence
$sql_orderby = '';

require 'std.list1.popup.inc';        // activate page controller

?>
