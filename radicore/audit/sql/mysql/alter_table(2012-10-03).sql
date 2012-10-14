USE `audit`;

ALTER TABLE `audit_fld` CHANGE `session_id` `session_id` BIGINT(20) UNSIGNED NOT NULL;
ALTER TABLE `audit_fld` CHANGE `tran_seq_no` `tran_seq_no` SMALLINT(6) UNSIGNED NOT NULL;
ALTER TABLE `audit_fld` CHANGE `table_seq_no` `table_seq_no` SMALLINT(6) UNSIGNED NOT NULL;

ALTER TABLE `audit_tbl` CHANGE `session_id` `session_id` BIGINT(20) UNSIGNED NOT NULL;
ALTER TABLE `audit_tbl` CHANGE `tran_seq_no` `tran_seq_no` SMALLINT(6) UNSIGNED NOT NULL;
ALTER TABLE `audit_tbl` CHANGE `table_seq_no` `table_seq_no` SMALLINT(6) UNSIGNED NOT NULL;

ALTER TABLE `audit_trn` CHANGE `session_id` `session_id` BIGINT(20) UNSIGNED NOT NULL;
ALTER TABLE `audit_trn` CHANGE `tran_seq_no` `tran_seq_no` SMALLINT(6) UNSIGNED NOT NULL;
