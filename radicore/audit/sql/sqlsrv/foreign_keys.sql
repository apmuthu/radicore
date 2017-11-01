-- use [audit];

DELETE FROM audit_trn WHERE NOT EXISTS (SELECT 1 FROM audit_ssn WHERE audit_ssn.session_id=audit_trn.session_id);
DELETE FROM audit_tbl WHERE NOT EXISTS (SELECT 1 FROM audit_trn WHERE audit_trn.session_id=audit_tbl.session_id AND audit_trn.tran_seq_no=audit_tbl.tran_seq_no);
DELETE FROM audit_fld WHERE NOT EXISTS (SELECT 1 FROM audit_tbl WHERE audit_tbl.session_id=audit_fld.session_id AND audit_tbl.tran_seq_no=audit_fld.tran_seq_no AND audit_tbl.table_seq_no=audit_fld.table_seq_no);


ALTER TABLE audit_trn ADD CONSTRAINT fk_audit_trn_audit_ssn FOREIGN KEY (session_id) REFERENCES audit_ssn(session_id) ON DELETE CASCADE;

ALTER TABLE audit_tbl ADD CONSTRAINT fk_audit_tbl_audit_trn FOREIGN KEY (session_id, tran_seq_no) REFERENCES audit_trn(session_id, tran_seq_no) ON DELETE CASCADE;

ALTER TABLE audit_fld ADD CONSTRAINT fk_audit_fld_audit_tbl FOREIGN KEY (session_id, tran_seq_no, table_seq_no) REFERENCES audit_tbl(session_id, tran_seq_no, table_seq_no) ON DELETE CASCADE;
