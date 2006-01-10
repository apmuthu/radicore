<?php
//*****************************************************************************
// Allow occurrences of the PERS_OPT_XREF table to be created. This links
// occurrences of the OPTION table with occurrences of the PERSON table.
// The value for PERSON_ID is passed from the previous screen while
// the list of one or more OPTION_IDs is provided by a separate popup screen.
//*****************************************************************************

//DebugBreak();
$table_id = 'x_pers_opt_xref';          // table name

$popup_screen = 'x_option(popup)';

require 'std.add3.inc';                 // activate page controller

?>

