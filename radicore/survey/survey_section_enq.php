<?php
//*****************************************************************************
// This will allow an occurrences of a database table to be displayed in detail.
// The identity of the selected occurrence is passed down from the previous screen.
//*****************************************************************************

$table_id = 'survey_section';                       // table id
$screen   = 'survey_section.detail.screen.inc';     // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = NULL;
$sql_from   = NULL;
$sql_where  = NULL;

require 'std.enquire1.inc';     // activate page controller

?>
