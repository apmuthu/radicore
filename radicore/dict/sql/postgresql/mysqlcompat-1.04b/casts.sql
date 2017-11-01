-- TIME TO INTEGER
CREATE OR REPLACE FUNCTION _time_to_integer(time with time zone)
RETURNS integer AS $$
  SELECT
    EXTRACT(HOUR FROM $1)::integer * 10000
    + EXTRACT(MINUTE FROM $1)::integer * 100
    + EXTRACT(SECONDS FROM $1)::integer
$$ IMMUTABLE STRICT LANGUAGE SQL;

DROP CAST IF EXISTS (time with time zone AS integer);
CREATE CAST (time with time zone AS integer)
  WITH FUNCTION _time_to_integer (time with time zone)
  AS IMPLICIT;

CREATE OR REPLACE FUNCTION _time_to_integer(time without time zone)
RETURNS integer AS $$
  SELECT
    EXTRACT(HOUR FROM $1)::integer * 10000
    + EXTRACT(MINUTE FROM $1)::integer * 100
    + EXTRACT(SECONDS FROM $1)::integer
$$ IMMUTABLE STRICT LANGUAGE SQL;

DROP CAST IF EXISTS (time without time zone AS integer);
CREATE CAST (time without time zone AS integer)
  WITH FUNCTION _time_to_integer (time without time zone)
  AS IMPLICIT;

-- DATE TO INTEGER
-- Note: requires explicit casts in some cases
CREATE OR REPLACE FUNCTION _date_to_integer(date)
RETURNS integer AS $$
  SELECT
    EXTRACT(YEAR FROM $1)::integer * 10000
    + EXTRACT(MONTH FROM $1)::integer * 100
    + EXTRACT(DAY FROM $1)::integer
$$ IMMUTABLE STRICT LANGUAGE SQL;

DROP CAST IF EXISTS (date AS integer);
CREATE CAST (date AS integer)
  WITH FUNCTION _date_to_integer (date)
  AS IMPLICIT;

-- TIMESTAMP TO BIGINT
-- Depends on: _time_to_integer and _date_to_integer
CREATE OR REPLACE FUNCTION _timestamp_to_bigint(timestamp with time zone)
RETURNS bigint AS $$
  SELECT _date_to_integer($1::date)::bigint * 1000000 + _time_to_integer($1::time)
$$ IMMUTABLE STRICT LANGUAGE SQL;

DROP CAST IF EXISTS (timestamp with time zone AS bigint);
CREATE CAST (timestamp with time zone AS bigint)
  WITH FUNCTION _timestamp_to_bigint (timestamp with time zone)
  AS IMPLICIT;

CREATE OR REPLACE FUNCTION _timestamp_to_bigint(timestamp without time zone)
RETURNS bigint AS $$
  SELECT _date_to_integer($1::date)::bigint * 1000000 + _time_to_integer($1::time)
$$ IMMUTABLE STRICT LANGUAGE SQL;

DROP CAST IF EXISTS (timestamp without time zone AS bigint);
CREATE CAST (timestamp without time zone AS bigint)
  WITH FUNCTION _timestamp_to_bigint (timestamp without time zone)
  AS IMPLICIT;

-- INTERVAL TO BIGINT
CREATE OR REPLACE FUNCTION _interval_to_bigint(interval)
RETURNS bigint AS $$
  SELECT
    EXTRACT(YEAR FROM $1)::bigint * 10000000000
    + EXTRACT(MONTH FROM $1)::bigint * 100000000
    + EXTRACT(DAY FROM $1)::bigint * 1000000
    + EXTRACT(HOUR FROM $1)::bigint * 10000
    + EXTRACT(MINUTE FROM $1)::bigint * 100
    + EXTRACT(SECONDS FROM $1)::bigint
$$ IMMUTABLE STRICT LANGUAGE SQL;

DROP CAST IF EXISTS (interval AS bigint);
CREATE CAST (interval AS bigint)
  WITH FUNCTION _interval_to_bigint (interval)
  AS IMPLICIT;

