<?php
//*****************************************************************************
// This will allow occurrences of the AUDIT_DTL table to be displayed.
//*****************************************************************************

$outer_table = 'audit_tbl';                     // name of outer table
$inner_table = 'audit_fld';                     // name of inner table
$screen      = 'audit_fld.list2.screen.inc';    // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = 'audit_tbl.*, audit_trn.date, audit_trn.time, task_id, user_id ';
$outer_sql_from   = 'audit_tbl '
                   .'LEFT JOIN audit_trn ON (audit_trn.session_id=audit_tbl.session_id AND audit_trn.tran_seq_no=audit_tbl.tran_seq_no) '
                   .'LEFT JOIN audit_ssn ON (audit_ssn.session_id=audit_trn.session_id) ';
$outer_sql_where  = NULL;

$inner_sql_select = '';
$inner_sql_from   = '';
$inner_sql_where  = '';
$inner_search_table = 'audit_tbl'; // this enable the 'previous search' button

// set default sort sequence
$outer_sql_orderby = 'date, time, tran_seq_no, table_seq_no';

require 'std.list2.inc';                        // activate page controller

?>
