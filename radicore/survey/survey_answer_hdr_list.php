<?php
//*****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

$table_id = 'survey_answer_hdr';    	            // table name
$screen   = 'survey_answer_hdr.list.screen.inc';    // file identifying screen structure

//require_once 'config.inc'; // obtain value for $dbprefix

// identify extra parameters for a JOIN
//$sql_select = 'survey_answer_id, answer_date, is_complete, user_name, node_desc, survey_name';
//$sql_from   = 'survey_answer_hdr ';
//$sql_from  .= 'LEFT JOIN ' .$dbprefix .'menu.mnu_user ON (mnu_user.user_id=survey_answer_hdr.user_id) ';
//$sql_from  .= 'LEFT JOIN tree_node ON (tree_node.node_id=survey_answer_hdr.node_id) '.
//              'LEFT JOIN survey_hdr ON (survey_hdr.survey_id=survey_answer_hdr.survey_id)';
//$sql_where  = '';
//$sql_orderby = NULL;

require 'std.list1.inc';        // activate page controller

?>
