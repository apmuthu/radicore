<?php
//*****************************************************************************
// This will allow occurrences of a database table to be updated.
// The identity of the selected occurrence is passed down from the previous screen.
//*****************************************************************************

$table_id = 'survey_question_s02';      // table id

// identify extra parameters for a JOIN
$sql_select = NULL;
$sql_from   = NULL;
$sql_where  = NULL;

require_once 'std.update4.inc';     // activate page controller

?>
