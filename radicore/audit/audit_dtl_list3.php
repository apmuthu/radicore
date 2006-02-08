<?php
//*****************************************************************************
// This will allow occurrences of the AUDIT_DTL table to be displayed.
//*****************************************************************************

$outer_table  = 'audit_tbl_key';                // name of outer table
$middle_table = 'audit_tbl_s01';                // name of inner table
$inner_table  = 'audit_fld';                    // name of inner table
$screen       = 'audit_fld.list3.screen.inc';   // file identifying screen structure

// identify extra parameters for a JOIN
$middle_sql_select = 'audit_tbl.*, audit_trn.date, audit_trn.time, task_id, user_id ';
$middle_sql_from   = 'audit_tbl '
                    .'LEFT JOIN audit_trn ON (audit_trn.session_id=audit_tbl.session_id AND audit_trn.tran_seq_no=audit_tbl.tran_seq_no) '
                    .'LEFT JOIN audit_ssn ON (audit_ssn.session_id=audit_trn.session_id) ';
$middle_sql_where  = NULL;

$inner_sql_select = '';
$inner_sql_from   = '';
$inner_sql_where  = '';

// set default sort sequence
$middle_sql_orderby = 'date, time, tran_seq_no, table_seq_no';

require 'std.list3.inc';                        // activate page controller

?>
