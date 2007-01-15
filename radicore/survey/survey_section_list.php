<?php
//*****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

$outer_table = 'survey_hdr';				    // name of outer table
$inner_table = 'survey_section';                // name of inner table
$screen   = 'survey_section.list.screen.inc';   // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = NULL;
$outer_sql_from   = NULL;
$outer_sql_where  = NULL;

$inner_sql_select = NULL;
$inner_sql_from   = NULL;
$inner_sql_where  = NULL;
$inner_sql_orderby = NULL;

require 'std.list2.inc';        // activate page controller

?>
