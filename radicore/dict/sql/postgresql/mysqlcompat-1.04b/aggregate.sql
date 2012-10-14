-- BIT_XOR
-- Note: only works for integers and bigints
CREATE OR REPLACE FUNCTION _bit_xor(bigint, bigint)
RETURNS bigint AS $$
  SELECT $1 # COALESCE($2, 0)
$$ IMMUTABLE LANGUAGE SQL;

DROP AGGREGATE IF EXISTS bit_xor(bigint);
CREATE AGGREGATE bit_xor (
	BASETYPE = bigint,
	SFUNC = _bit_xor,
	STYPE = bigint,
	INITCOND = 0
);

-- GROUP_CONCAT()
-- Note: only supports the comma separator
-- Note: For DISTINCT and ORDER BY a subquery is required
CREATE OR REPLACE FUNCTION _group_concat(text, text)
RETURNS text AS $$
  SELECT CASE
    WHEN $2 IS NULL THEN $1
    WHEN $1 IS NULL THEN $2
    ELSE $1 operator(pg_catalog.||) ',' operator(pg_catalog.||) $2
  END
$$ IMMUTABLE LANGUAGE SQL;

DROP AGGREGATE IF EXISTS group_concat(text);
CREATE AGGREGATE group_concat (
	BASETYPE = text,
	SFUNC = _group_concat,
	STYPE = text
);

