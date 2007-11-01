SET search_path TO "workflow";

ALTER TABLE workflow.wf_case ADD COLUMN rdcaccount_id integer;
ALTER TABLE workflow.wf_case ALTER COLUMN rdcaccount_id SET NOT NULL;
ALTER TABLE workflow.wf_case ALTER COLUMN rdcaccount_id SET DEFAULT 1;
CREATE INDEX wf_case_index2 ON workflow.wf_case USING btree (rdcaccount_id);

ALTER TABLE workflow.wf_token ADD COLUMN rdcaccont_id integer;
ALTER TABLE workflow.wf_token ALTER COLUMN rdcaccont_id SET NOT NULL;
ALTER TABLE workflow.wf_token ALTER COLUMN rdcaccont_id SET DEFAULT 1;
CREATE INDEX wf_token_index2 ON workflow.wf_token USING btree (rdcaccont_id);

ALTER TABLE workflow.wf_workitem ADD COLUMN rdcaccount_id integer;
ALTER TABLE workflow.wf_workitem ALTER COLUMN rdcaccount_id SET NOT NULL;
ALTER TABLE workflow.wf_workitem ALTER COLUMN rdcaccount_id SET DEFAULT 1;
CREATE INDEX wf_workitem_index2 ON workflow.wf_workitem USING btree (rdcaccount_id);
