<?php
//*****************************************************************************
// List the contents of the PERSON table for a particular value of OPTION_ID
// (as selected in the previous screen) and allow the user to view/modify
// the contents by activating other screens via navigation buttons. 
//*****************************************************************************

//DebugBreak();
$outer_table = 'x_option';                  // name of outer table
$inner_table = 'x_pers_opt_xref';           // name of inner table
$screen   = 'person.list(b).screen.inc';    // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = NULL;
$outer_sql_from   = NULL;
$outer_sql_where  = NULL;

$inner_sql_select = 'x_pers_opt_xref.person_id,option_id,first_name,last_name,star_sign';
$inner_sql_from   = 'x_pers_opt_xref '.
                    'LEFT JOIN x_person ON (x_person.person_id=x_pers_opt_xref.person_id)';
$inner_sql_where  = '';
$inner_search_table = 'x_person';

// set default sort sequence
$inner_sql_orderby = 'x_person.last_name';

require 'std.list2.inc';                    // activate page controller

?>
