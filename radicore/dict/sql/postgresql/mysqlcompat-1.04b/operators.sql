-- <=> NULL SAFE COMPARISON
-- Note: needs casts in some circumstances
CREATE OR REPLACE FUNCTION _null_safe_cmp(anyelement, anyelement)
RETURNS boolean AS '
  SELECT NOT ($1 IS DISTINCT FROM $2)
' IMMUTABLE LANGUAGE SQL;

DROP OPERATOR IF EXISTS <=>(anyelement, anyelement);
CREATE OPERATOR <=> (
  PROCEDURE = _null_safe_cmp,
  LEFTARG = anyelement,
  RIGHTARG = anyelement
);

-- &&
-- XXX: MySQL version has wacky null behaviour 
CREATE OR REPLACE FUNCTION _and(boolean, boolean)
RETURNS boolean AS $$
  SELECT $1 AND $2
$$ IMMUTABLE STRICT LANGUAGE SQL;

DROP OPERATOR IF EXISTS &&(boolean, boolean);
CREATE OPERATOR && (
  leftarg = boolean,
  rightarg = boolean,
  procedure = _and,
  commutator = &&
);

-- ||
-- XXX: MySQL version has wacky null behaviour 
-- This replaces the SQL standard || concatenation operator
CREATE OR REPLACE FUNCTION _or(boolean, boolean)
RETURNS boolean AS $$
  SELECT $1 OR $2
$$ IMMUTABLE STRICT LANGUAGE SQL;

DROP OPERATOR IF EXISTS ||(boolean, boolean);
CREATE OPERATOR || (
  leftarg = boolean,
  rightarg = boolean,
  procedure = _or,
  commutator = || 
);
