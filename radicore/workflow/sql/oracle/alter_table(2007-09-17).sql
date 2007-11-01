ALTER SESSION SET CURRENT_SCHEMA = "WORKFLOW";

ALTER TABLE WORKFLOW.WF_CASE ADD (rdcaccount_id  NUMBER(10) DEFAULT 1 NOT NULL);
CREATE INDEX workflow.wf_case_idx2 ON workflow.WF_CASE (rdcaccount_id);

ALTER TABLE WORKFLOW.WF_TOKEN ADD (rdcaccont_id NUMBER(10) DEFAULT 1 NOT NULL);
CREATE INDEX workflow.wf_token_idx2 ON workflow.WF_TOKEN (rdcaccont_id);

ALTER TABLE WORKFLOW.WF_WORKITEM ADD (rdcaccount_id NUMBER(10) DEFAULT 1 NOT NULL);
CREATE INDEX workflow.wf_workitem_idx2 ON workflow.WF_WORKITEM (rdcaccount_id);