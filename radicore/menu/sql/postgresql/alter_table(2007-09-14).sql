SET search_path TO "menu";

CREATE TABLE mnu_account (
  rdcaccount_id serial NOT NULL,
  account_name character varying(255) NOT NULL,
  rdcversion integer default 1 NOT NULL,
  created_date timestamp NOT NULL,
  created_user character varying(16) NOT NULL default 'UNKNOWN'::character varying ,
  revised_date timestamp,
  revised_user character varying(16),
  PRIMARY KEY  (rdcaccount_id)
);

REVOKE ALL ON TABLE mnu_account FROM PUBLIC;
REVOKE ALL ON TABLE mnu_account FROM postgres;
GRANT ALL ON TABLE mnu_account TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_account TO PUBLIC;

ALTER TABLE MENU.MNU_USER ADD rdcaccount_id integer;
CREATE INDEX mnu_user_index2 ON mnu_user USING btree (rdcaccount_id);

INSERT INTO `mnu_account` (`rdcaccount_id`, `account_name`, `rdcversion`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES
(1, 'Shared Account', 1, '2007-09-13 11:41:52', 'AJM', NULL, NULL);

