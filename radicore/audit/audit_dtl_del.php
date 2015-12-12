<?php
//*****************************************************************************
// This will allow occurrences of the OUTER database table to be deleted, as well
// as all related occurrences on the INNER table.
// The identity of the selected OUTER occurrence(s) is passed from the previous screen.
//*****************************************************************************

$outer_table = 'audit_tbl';                     // name of outer (parent) table
$inner_table = 'audit_fld';                     // name of inner (child) table
$screen      = 'audit_fld.list2.screen.inc';    // file identifying screen structure

// customise the SQL SELECT statement
$outer_sql_select = 'audit_tbl.*, trn_datetime, task_id, user_id ';
$outer_sql_from   = 'audit_tbl '
                   .'LEFT JOIN audit_trn ON (audit_trn.session_id=audit_tbl.session_id AND audit_trn.tran_seq_no=audit_tbl.tran_seq_no) '
                   .'LEFT JOIN audit_ssn ON (audit_ssn.session_id=audit_trn.session_id) ';

$inner_sql_select   = null;
$inner_sql_from     = null;
$inner_sql_where    = null;
$inner_sql_groupby  = null;
$inner_sql_having   = null;
$inner_sql_orderby  = null;
$inner_search_table = null;

require 'std.delete4.inc';            // activate page controller

?>
