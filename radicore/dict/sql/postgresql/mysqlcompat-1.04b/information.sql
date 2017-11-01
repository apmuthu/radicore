-- BENCHMARK()
-- Note: This version requires the expression to be quoted.
-- Note: To show query times in psql, run \timing first
-- Example: SELECT BENCHMARK(100000, $$ length('hello') $$);
CREATE OR REPLACE FUNCTION benchmark(integer, text)
RETURNS integer AS $$
  BEGIN
    FOR i IN 1..$1 LOOP
      EXECUTE 'SELECT ' || $2;
    END LOOP;
    RETURN 0;
  END;
$$ STRICT LANGUAGE PLPGSQL;

-- CHARSET()
-- This is a bit dodgy as it just returns the database encoding
CREATE OR REPLACE FUNCTION charset(text)
RETURNS text AS $$
  SELECT pg_catalog.lower(setting) from pg_catalog.pg_settings where name='server_encoding'
$$ IMMUTABLE LANGUAGE SQL;

-- COERCIBILITY()
-- This is a bit dodgy as PostgreSQL does not support collations
-- Note: This is MySQL 5.0 compatible
CREATE OR REPLACE FUNCTION coercibility(name)
RETURNS integer AS $$
  SELECT 3
$$ IMMUTABLE LANGUAGE SQL;

CREATE OR REPLACE FUNCTION coercibility(text)
RETURNS integer AS $$
  SELECT CASE
    WHEN $1 IS NULL THEN 5
    ELSE 2
  END
$$ IMMUTABLE LANGUAGE SQL;

-- COLLATION()
-- This is a bit dodgy as it just returns the database collation
CREATE OR REPLACE FUNCTION collation(text)
RETURNS text AS $$
  SELECT pg_catalog.lower(setting) from pg_catalog.pg_settings where name='lc_collate'
$$ IMMUTABLE LANGUAGE SQL;

-- CONNECTION_ID()
CREATE OR REPLACE FUNCTION connection_id()
RETURNS integer AS $$ 
  SELECT pg_catalog.pg_backend_pid()
$$ IMMUTABLE LANGUAGE SQL;

-- DATABASE()
CREATE OR REPLACE FUNCTION database()
RETURNS text AS $$
  SELECT pg_catalog.current_database()::text
$$ IMMUTABLE LANGUAGE SQL;

-- FOUND_ROWS()
-- Not possible to implement

-- LAST_INSERT_ID()
-- Note: only works in 8.1
-- Note: Not possible to implement last_insert_id(val)
CREATE OR REPLACE FUNCTION last_insert_id()
RETURNS bigint AS $$
  SELECT pg_catalog.lastval()
$$ VOLATILE LANGUAGE SQL;

-- ROW_COUNT()
-- Not possible to implement

-- SCHEMA()
-- XXX: Should this be an alias to database() like in mysql?
CREATE OR REPLACE FUNCTION schema()
RETURNS text AS $$
  SELECT pg_catalog.current_schema()::text
$$ VOLATILE LANGUAGE SQL;

-- SESSION_USER()
-- Cannot be implemented

-- SYSTEM_USER()
CREATE OR REPLACE FUNCTION system_user()
RETURNS text AS $$
  SELECT SESSION_USER::text
$$ VOLATILE LANGUAGE SQL;

-- USER()
-- Cannot be implemented
