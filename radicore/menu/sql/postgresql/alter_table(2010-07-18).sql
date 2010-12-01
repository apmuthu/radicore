SET search_path TO "menu";

ALTER TABLE menu.mnu_task ADD COLUMN task_id_run_at_end character varying(80);
ALTER TABLE menu.mnu_task ADD COLUMN task_id_run_at_cancel character varying(80);

ALTER TABLE menu.mnu_task ALTER initial_passthru TYPE character varying(80);
