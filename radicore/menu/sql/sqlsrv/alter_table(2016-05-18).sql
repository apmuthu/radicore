-- USE [menu];

ALTER TABLE "dbo"."mnu_task_field" ADD "is_documentation_only" char(1) NOT NULL DEFAULT 'N';

CREATE TABLE mnu_task_quicksearch (
  task_id nvarchar(80) NOT NULL,
  field_id nvarchar(40) NOT NULL,
  sort_seq smallint NOT NULL DEFAULT '0',
  field_name nvarchar(40) NOT NULL,
  created_date datetime2 NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2 DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (task_id,field_id)
);

CREATE TABLE mnu_task_quicksearch_alt (
  task_id nvarchar(80) NOT NULL,
  field_id nvarchar(40) NOT NULL,
  language_id nvarchar(5) NOT NULL,
  field_name nvarchar(40) NOT NULL,
  created_date datetime2 NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2 DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (task_id,field_id,language_id)
);
