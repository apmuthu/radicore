<?php
//*****************************************************************************
// List the contents of the OPTION table for a particular value of PERSON_ID
// (as selected in the previous screen) and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

//DebugBreak();
$outer_table = 'x_person';                  // name of outer table
$inner_table = 'x_pers_opt_xref';           // name of inner table
$screen   = 'option.list(a).screen.inc';    // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = 'person_id, CONCAT(first_name, \' \', last_name) AS person_name';
$outer_sql_from   = '';
$outer_sql_where  = NULL;

$inner_sql_select = 'x_pers_opt_xref.option_id, x_pers_opt_xref.person_id, x_option.option_desc';
$inner_sql_from   = 'x_pers_opt_xref '.
                    'LEFT JOIN x_option ON (x_option.option_id=x_pers_opt_xref.option_id)';
$inner_sql_where  = '';
$inner_search_table = 'x_option';

// set default sort sequence
$inner_sql_orderby = 'x_pers_opt_xref.option_id';

require 'std.list2.inc';                    // activate page controller

?>
