-- BIT_COUNT()
CREATE OR REPLACE FUNCTION bit_count(bigint)
RETURNS integer AS $$
  SELECT pg_catalog.length(pg_catalog.replace(pg_catalog.ltrim(pg_catalog.textin(pg_catalog.bit_out($1::bit(64))), '0'), '0', ''));
$$ IMMUTABLE STRICT LANGUAGE SQL;
