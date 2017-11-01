-- this bugfix is required for versions of PostgreSQL which are less than 8.2

CREATE OR REPLACE VIEW information_schema.columns AS 
 SELECT current_database()::information_schema.sql_identifier AS table_catalog, nc.nspname::information_schema.sql_identifier AS table_schema, c.relname::information_schema.sql_identifier AS table_name, a.attname::information_schema.sql_identifier AS column_name, a.attnum::information_schema.cardinal_number AS ordinal_position, 
        ad.adsrc::information_schema.character_data AS column_default, 
        CASE
            WHEN a.attnotnull OR t.typtype = 'd'::"char" AND t.typnotnull THEN 'NO'::text
            ELSE 'YES'::text
        END::information_schema.character_data AS is_nullable, 
        CASE
            WHEN t.typtype = 'd'::"char" THEN 
            CASE
                WHEN bt.typelem <> 0::oid AND bt.typlen = -1 THEN 'ARRAY'::text
                WHEN nbt.nspname = 'pg_catalog'::name THEN format_type(t.typbasetype, NULL::integer)
                ELSE 'USER-DEFINED'::text
            END
            ELSE 
            CASE
                WHEN t.typelem <> 0::oid AND t.typlen = -1 THEN 'ARRAY'::text
                WHEN nt.nspname = 'pg_catalog'::name THEN format_type(a.atttypid, NULL::integer)
                ELSE 'USER-DEFINED'::text
            END
        END::information_schema.character_data AS data_type, information_schema._pg_char_max_length(information_schema._pg_truetypid(a.*, t.*), information_schema._pg_truetypmod(a.*, t.*))::information_schema.cardinal_number AS character_maximum_length, information_schema._pg_char_octet_length(information_schema._pg_truetypid(a.*, t.*), information_schema._pg_truetypmod(a.*, t.*))::information_schema.cardinal_number AS character_octet_length, information_schema._pg_numeric_precision(information_schema._pg_truetypid(a.*, t.*), information_schema._pg_truetypmod(a.*, t.*))::information_schema.cardinal_number AS numeric_precision, information_schema._pg_numeric_precision_radix(information_schema._pg_truetypid(a.*, t.*), information_schema._pg_truetypmod(a.*, t.*))::information_schema.cardinal_number AS numeric_precision_radix, information_schema._pg_numeric_scale(information_schema._pg_truetypid(a.*, t.*), information_schema._pg_truetypmod(a.*, t.*))::information_schema.cardinal_number AS numeric_scale, information_schema._pg_datetime_precision(information_schema._pg_truetypid(a.*, t.*), information_schema._pg_truetypmod(a.*, t.*))::information_schema.cardinal_number AS datetime_precision, NULL::information_schema.character_data::information_schema.character_data AS interval_type, NULL::information_schema.character_data::information_schema.character_data AS interval_precision, NULL::information_schema.sql_identifier::information_schema.sql_identifier AS character_set_catalog, NULL::information_schema.sql_identifier::information_schema.sql_identifier AS character_set_schema, NULL::information_schema.sql_identifier::information_schema.sql_identifier AS character_set_name, NULL::information_schema.sql_identifier::information_schema.sql_identifier AS collation_catalog, NULL::information_schema.sql_identifier::information_schema.sql_identifier AS collation_schema, NULL::information_schema.sql_identifier::information_schema.sql_identifier AS collation_name, 
        CASE
            WHEN t.typtype = 'd'::"char" THEN current_database()
            ELSE NULL::name
        END::information_schema.sql_identifier AS domain_catalog, 
        CASE
            WHEN t.typtype = 'd'::"char" THEN nt.nspname
            ELSE NULL::name
        END::information_schema.sql_identifier AS domain_schema, 
        CASE
            WHEN t.typtype = 'd'::"char" THEN t.typname
            ELSE NULL::name
        END::information_schema.sql_identifier AS domain_name, current_database()::information_schema.sql_identifier AS udt_catalog, COALESCE(nbt.nspname, nt.nspname)::information_schema.sql_identifier AS udt_schema, COALESCE(bt.typname, t.typname)::information_schema.sql_identifier AS udt_name, NULL::information_schema.sql_identifier::information_schema.sql_identifier AS scope_catalog, NULL::information_schema.sql_identifier::information_schema.sql_identifier AS scope_schema, NULL::information_schema.sql_identifier::information_schema.sql_identifier AS scope_name, NULL::information_schema.cardinal_number::information_schema.cardinal_number AS maximum_cardinality, a.attnum::information_schema.sql_identifier AS dtd_identifier, 'NO'::information_schema.character_data::information_schema.character_data AS is_self_referencing
   FROM pg_attribute a
   LEFT JOIN pg_attrdef ad ON a.attrelid = ad.adrelid AND a.attnum = ad.adnum, pg_class c, pg_namespace nc, pg_user u, pg_type t
   JOIN pg_namespace nt ON t.typnamespace = nt.oid
   LEFT JOIN (pg_type bt
   JOIN pg_namespace nbt ON bt.typnamespace = nbt.oid) ON t.typtype = 'd'::"char" AND t.typbasetype = bt.oid
  WHERE a.attrelid = c.oid AND a.atttypid = t.oid AND u.usesysid = c.relowner AND nc.oid = c.relnamespace AND a.attnum > 0 AND NOT a.attisdropped AND (c.relkind = 'r'::"char" OR c.relkind = 'v'::"char") AND (u.usename = "current_user"() OR has_table_privilege(c.oid, 'SELECT'::text) OR has_table_privilege(c.oid, 'INSERT'::text) OR has_table_privilege(c.oid, 'UPDATE'::text) OR has_table_privilege(c.oid, 'REFERENCES'::text));