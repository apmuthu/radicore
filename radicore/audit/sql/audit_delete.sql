DELETE FROM ssn, trn, tbl, fld 
USING audit_ssn AS ssn
LEFT JOIN audit_trn AS trn ON (trn.session_id=ssn.session_id)
LEFT JOIN audit_tbl AS tbl ON (tbl.session_id=trn.session_id 
                           AND tbl.tran_seq_no=trn.tran_seq_no)
LEFT JOIN audit_fld AS fld ON (fld.session_id=tbl.session_id 
                            AND fld.tran_seq_no=tbl.tran_seq_no
                            AND fld.table_seq_no=tbl.table_seq_no)
WHERE ssn.ssn_date<'2010-01-01'