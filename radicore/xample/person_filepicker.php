<?php
//*****************************************************************************
// This will display the contents of a subdirectory and allow the user to
// chose one of the files.
//*****************************************************************************

$table_id = 'x_person';                     // table id
$screen   = 'person.filepicker.screen.inc'; // file identifying screen structure

$sql_search_table = 'mnu_file';

// activate page controller
require 'std.filepicker1.inc';

?>
