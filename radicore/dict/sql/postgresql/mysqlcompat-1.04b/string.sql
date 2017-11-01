-- BIN()
CREATE OR REPLACE FUNCTION bin(bigint)
RETURNS text AS $$ 
  SELECT pg_catalog.ltrim(pg_catalog.textin(pg_catalog.bit_out($1::bit(64))), '0');
$$ IMMUTABLE STRICT LANGUAGE SQL;

-- CHAR()
-- Not implemented

-- COMPRESS
-- Not implemented

-- CONCAT
CREATE OR REPLACE FUNCTION concat(text)
RETURNS text AS $$
  SELECT $1
$$ IMMUTABLE STRICT LANGUAGE SQL;

CREATE OR REPLACE FUNCTION concat(text, text)
RETURNS text AS $$
  SELECT $1 operator(pg_catalog.||) $2
$$ IMMUTABLE STRICT LANGUAGE SQL;

CREATE OR REPLACE FUNCTION concat(text, text, text)
RETURNS text AS $$
  SELECT $1 operator(pg_catalog.||) $2 operator(pg_catalog.||) $3
$$ IMMUTABLE STRICT LANGUAGE SQL;

-- CONCAT_WS
-- Note: fails in this case: select concat_ws(',', 'First name', null);
CREATE OR REPLACE FUNCTION concat_ws(text, text)
RETURNS text AS $$
  SELECT CASE
    WHEN $1 IS NULL THEN NULL
    ELSE $2
  END
$$ IMMUTABLE LANGUAGE SQL;

CREATE OR REPLACE FUNCTION concat_ws(text, text, text)
RETURNS text AS $$
  SELECT CASE
    WHEN $1 IS NULL THEN NULL
    ELSE
      coalesce($2 operator(pg_catalog.||) $1, '') operator(pg_catalog.||) coalesce($3, '')
  END
$$ IMMUTABLE LANGUAGE SQL;

CREATE OR REPLACE FUNCTION concat_ws(text, text, text, text)
RETURNS text AS $$
  SELECT CASE
    WHEN $1 IS NULL THEN NULL
    ELSE 
      coalesce($2 operator(pg_catalog.||) $1, '') operator(pg_catalog.||) coalesce($3 operator(pg_catalog.||) $1, '') operator(pg_catalog.||) coalesce($4, '')
  END
$$ IMMUTABLE LANGUAGE SQL;

-- CONV()
-- Credit: Gavin Sherry
create or replace function _todec(text, int)
returns int as $$
declare
    num int := 0;
    hex text := '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    pos int := 0;
    chr text;
    numin alias for $1;
    base alias for $2;
begin
    if numin isnull or base isnull then
        return null;
    end if;
    for i in 1 .. pg_catalog.length(numin) loop
        pos := pg_catalog.abs(position(pg_catalog.upper(substring(numin from i for 1)) in hex) - 1);
        num := num * base + pos;
    end loop;
    return num;
end$$
language plpgsql
RETURNS NULL ON NULL INPUT
IMMUTABLE;

create or replace function conv(text, int, int)
returns text as
$$
declare
    res text := '';
    hex text := '0123456789ABCDEFGHIJLMNOPQRSTUVWXYZ';
    num int;
    tmp int;
    tmp2 text;
    numin text;
    tobase int;
    isneg bool := false;
    numin_p ALIAS FOR $1;
    frombase ALIAS FOR $2;
    tobase_p ALIAS FOR $3;
begin
    if substring(numin_p, 1, 1) = '-' and tobase_p < 0 then
      isneg := true;
      numin := substring(numin_p, 2, length(numin_p));
      tobase := tobase_p * -1;
    else
      numin := numin_p;
      tobase := tobase_p;
    end if;

    if numin isnull OR frombase isnull OR tobase ISNULL then
        return NULL;
    elsif frombase < 0 OR frombase > 36 then
        return NULL;
    elsif tobase < 0 OR tobase > 36 then
        return NULL;
    end if;
 
    if frombase <> 10 then
        num := _todec(numin, frombase);
    else
        num := numin::int;
    end if;
 
    loop
        tmp := num % tobase + 1;
        res := substring( hex from tmp for 1 ) operator(pg_catalog.||) res;
        num := num/tobase;
        if num = 0 then
            exit;
        end if;
    end loop;
    if isneg then
        return '-' operator(pg_catalog.||) res;
    else
        return res;
    end if;
end
$$
language plpgsql
RETURNS NULL ON NULL INPUT
IMMUTABLE;

CREATE OR REPLACE FUNCTION conv(int, int, int)
RETURNS text AS $$
  SELECT conv($1::text, $2, $3);
$$ IMMUTABLE STRICT LANGUAGE SQL;
 
-- ELT()
CREATE OR REPLACE FUNCTION elt(integer, text, text)
RETURNS text AS $$
  SELECT CASE
    WHEN $1 < 1 OR $1 > 2 THEN NULL
    WHEN $1 = 1 THEN $2
    ELSE $3
  END 
$$ IMMUTABLE LANGUAGE SQL;

CREATE OR REPLACE FUNCTION elt(integer, text, text, text)
RETURNS text AS $$
  SELECT CASE
    WHEN $1 < 1 OR $1 > 3 THEN NULL
    WHEN $1 = 1 THEN $2
    WHEN $1 = 2 THEN $3
    ELSE $4
  END 
$$ IMMUTABLE LANGUAGE SQL;

CREATE OR REPLACE FUNCTION elt(integer, text, text, text, text)
RETURNS text AS $$
  SELECT CASE
    WHEN $1 < 1 OR $1 > 4 THEN NULL
    WHEN $1 = 1 THEN $2
    WHEN $1 = 2 THEN $3
    WHEN $1 = 3 THEN $4
    ELSE $5
  END 
$$ IMMUTABLE LANGUAGE SQL;

-- REVERSE()
CREATE OR REPLACE FUNCTION reverse(text)
RETURNS text AS $$
  DECLARE
    temp TEXT;
    count INTEGER;
  BEGIN
    temp := '';
    count := pg_catalog.length($1);
    FOR i IN REVERSE count..1 LOOP
      temp := temp  operator(pg_catalog.||)  substring($1 from i for 1);
    END LOOP;
    RETURN temp;
  END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

-- EXPORT_SET()
-- Depends on: BIN() and REVERSE()
-- XXX: WILL fail if $2 is '0'
CREATE OR REPLACE FUNCTION export_set(bigint, text, text, text, integer)
RETURNS text AS $$
  SELECT pg_catalog.rtrim(pg_catalog.replace(pg_catalog.replace(reverse(pg_catalog.lpad(bin($1), $5, '0')), '1', $2 operator(pg_catalog.||) $4), '0', $3 operator(pg_catalog.||) $4), $4)
$$ IMMUTABLE STRICT LANGUAGE SQL;

CREATE OR REPLACE FUNCTION export_set(bigint, text, text, text)
RETURNS text AS $$
  SELECT export_set($1, $2, $3, $4, 64)
$$ IMMUTABLE STRICT LANGUAGE SQL;

CREATE OR REPLACE FUNCTION export_set(bigint, text, text)
RETURNS text AS $$
  SELECT export_set($1, $2, $3, ',', 64)
$$ IMMUTABLE STRICT LANGUAGE SQL;

-- FIELD()
CREATE OR REPLACE FUNCTION field(text, text, text)
RETURNS integer AS $$
  SELECT CASE
    WHEN $1 = $2 THEN 1
    WHEN $1 = $3 THEN 2
    ELSE 0
  END 
$$ IMMUTABLE LANGUAGE SQL;

CREATE OR REPLACE FUNCTION field(text, text, text, text)
RETURNS integer AS $$
  SELECT CASE
    WHEN $1 = $2 THEN 1
    WHEN $1 = $3 THEN 2
    WHEN $1 = $4 THEN 3
    ELSE 0
  END 
$$ IMMUTABLE LANGUAGE SQL;

CREATE OR REPLACE FUNCTION field(text, text, text, text, text)
RETURNS integer AS $$
  SELECT CASE
    WHEN $1 = $2 THEN 1
    WHEN $1 = $3 THEN 2
    WHEN $1 = $4 THEN 3
    WHEN $1 = $5 THEN 4
    ELSE 0
  END 
$$ IMMUTABLE LANGUAGE SQL;

-- FIND_IN_SET()
CREATE OR REPLACE FUNCTION find_in_set(text, text)
RETURNS integer AS $$
  DECLARE
    list text[];
    len integer;
  BEGIN
    IF $2 = '' THEN
      RETURN 0;
    END IF;
    list := pg_catalog.string_to_array($2, ',');
    len := pg_catalog.array_upper(list, 1);
    FOR i IN 1..len LOOP
      IF list[i] = $1 THEN
        RETURN i;
      END IF;
    END LOOP;
    RETURN 0;
  END;
$$ STRICT IMMUTABLE LANGUAGE PLPGSQL;

-- HEX()
CREATE OR REPLACE FUNCTION hex(integer)
RETURNS text AS $$
  SELECT pg_catalog.upper(pg_catalog.to_hex($1))
$$ IMMUTABLE STRICT LANGUAGE SQL;

CREATE OR REPLACE FUNCTION hex(bigint)
RETURNS text AS $$
  SELECT pg_catalog.upper(pg_catalog.to_hex($1))
$$ IMMUTABLE STRICT LANGUAGE SQL;

CREATE OR REPLACE FUNCTION hex(text)
RETURNS text AS $$
  DECLARE
    len integer;
    temp text;
  BEGIN
    len := pg_catalog.length($1);
    temp := '';
    FOR i IN 1..len LOOP
      temp := temp operator(pg_catalog.||) pg_catalog.to_hex(pg_catalog.ascii(SUBSTRING($1 FROM i FOR 1)));
    END LOOP;
    RETURN pg_catalog.upper(temp);
  END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

-- FORMAT()
-- See: mathematical.sql

-- INSERT()
CREATE OR REPLACE FUNCTION insert(text, integer, integer, text)
RETURNS text AS $$
  SELECT CASE
    WHEN NOT $2 BETWEEN 1 AND pg_catalog.length($1) THEN $1
    ELSE overlay($1 placing $4 from $2 for $3)
  END
$$ IMMUTABLE STRICT LANGUAGE SQL;

-- INSTR()
CREATE OR REPLACE FUNCTION instr(text, text)
RETURNS integer AS $$
  SELECT POSITION($2 IN $1)
$$ IMMUTABLE STRICT LANGUAGE SQL;

-- LCASE()
CREATE OR REPLACE FUNCTION lcase(text)
RETURNS text AS $$
  SELECT pg_catalog.lower($1)
$$ IMMUTABLE STRICT LANGUAGE SQL;

-- LEFT()
CREATE OR REPLACE FUNCTION left(text, integer)
RETURNS text AS $$
  SELECT substring($1 FOR $2);
$$ IMMUTABLE STRICT LANGUAGE SQL;

-- LOAD_FILE()
-- Not implemented

-- LOCATE()
CREATE OR REPLACE FUNCTION locate(text, text, integer)
RETURNS integer AS $$
  SELECT POSITION($1 IN SUBSTRING ($2 FROM $3)) + $3 - 1
$$ IMMUTABLE STRICT LANGUAGE SQL;

CREATE OR REPLACE FUNCTION locate(text, text)
RETURNS integer AS $$
  SELECT locate($1, $2, 1)
$$ IMMUTABLE STRICT LANGUAGE SQL;

-- MAKE_SET()
-- routine to make make_set() easier
-- note: since arrays do not support NULLs until 8.2, we cannot
-- handle NULL arguments to make_set()
-- note: we only support 32 arguments to make_set() as PostgreSQL
-- does not support arbitary argument lists
CREATE OR REPLACE FUNCTION _make_set(bigint, text[])
RETURNS text AS $$
  DECLARE
    up int;
    i int = 1;
    ret text = '';
    dat ALIAS FOR $2;
    found bool = false;
    mask bigint = 1;
  BEGIN
    up = array_upper($2, 1);
    IF up > 31 THEN
      RAISE EXCEPTION 'maximum array size exceeded';
      RETURN NULL;
    END IF;
    WHILE i <= up LOOP
      IF $1 & mask <> 0 THEN
        IF found = false THEN
          found = true;
        ELSE
          ret = ret operator(pg_catalog.||) ',';
        END IF;
        ret = ret operator(pg_catalog.||) dat[i];
      END IF;
      i = i + 1;
      mask = mask << 1;
    END LOOP;
    RETURN ret;
  END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION make_set(bigint, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7, $8];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7, $8, $9];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7, $8, $9, $10];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7, $8, $9, $10, $11];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text, text, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text, text, text, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION make_set(bigint, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text, text)
RETURNS text AS $$
  DECLARE
    a text[];
  BEGIN
    a = ARRAY[$2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32];
RETURN _make_set($1, a);
END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

-- MID()
CREATE OR REPLACE FUNCTION mid(text, integer, integer)
RETURNS text AS $$
  SELECT pg_catalog.substring($1, $2, $3)
$$ IMMUTABLE STRICT LANGUAGE SQL;

-- OCT()
-- Depends on: CONV()
CREATE OR REPLACE FUNCTION oct(integer)
RETURNS text AS $$
  SELECT conv($1, 10, 8)
$$ IMMUTABLE STRICT LANGUAGE SQL;

-- OCTET_LENGTH()
-- not reimplemented

-- ORD()
-- Note: Does not support multibyte
CREATE OR REPLACE FUNCTION ord(text)
RETURNS integer AS $$
  SELECT pg_catalog.ascii($1)
$$ IMMUTABLE STRICT LANGUAGE SQL;

-- QUOTE()
CREATE OR REPLACE FUNCTION quote(text)
RETURNS text AS $$
  SELECT CASE
    WHEN $1 IS NULL THEN 'NULL'
    ELSE pg_catalog.quote_literal($1)
  END
$$ IMMUTABLE LANGUAGE SQL;

-- REVERSE()
-- See above.  Needed by EXPORT_SET().

-- RIGHT()
CREATE OR REPLACE FUNCTION right(text, integer)
RETURNS text AS $$
  SELECT substring($1 FROM pg_catalog.length($1) + 1 - $2);
$$ IMMUTABLE STRICT LANGUAGE SQL;

-- SOUNDEX()
-- Thanks to Fredrik Olsson for the original soundex() function.
CREATE OR REPLACE FUNCTION _soundexcode(char(1))
RETURNS char(1) AS $$
  SELECT COALESCE(
    (ARRAY['0', '1', '2', '3', '0', 
           '1', '2', '0', '0', '2', 
           '2', '4', '5', '5', '0', 
           '1', '2', '6', '2', '3', 
           '0', '1', '0', '2', '0', '2'])[pg_catalog.ascii($1) - 64],
     '0');
$$ IMMUTABLE STRICT LANGUAGE SQL;

CREATE OR REPLACE FUNCTION soundex(text) RETURNS text AS $$
DECLARE
        a_text alias for $1;
	l_text text;
	l_lchr char(1);
	l_chr char(1);
	l_ret text;
BEGIN
	l_text := pg_catalog.upper(trim(both from a_text));
	IF l_text = '' THEN
		RETURN '0000';
	END IF;
	l_chr := substring(l_text FOR 1);
	l_ret := l_chr;
	l_text := substring(l_text FROM 2);
	WHILE (l_text <> '') LOOP
		l_lchr := l_chr; 
		l_chr := substring(l_text FOR 1);
		l_text := substring(l_text FROM 2);
		IF (pg_catalog.ascii(l_chr) BETWEEN 65 AND 90) AND
				(_soundexcode(l_chr) <> _soundexcode(l_lchr)) THEN
			IF _soundexcode(l_chr) <> '0' THEN
				l_ret := l_ret operator(pg_catalog.||) _soundexcode(l_chr);
			END IF;
		END IF;
	END LOOP;
	IF pg_catalog.length(l_ret) < 4 THEN
	 	l_ret := rpad(l_ret, 4, '0');
	END IF;
	RETURN l_ret;
END;
$$ IMMUTABLE STRICT LANGUAGE plpgsql;

-- SPACE()
CREATE OR REPLACE FUNCTION space(integer)
RETURNS text AS $$
  SELECT pg_catalog.repeat(' ', $1)
$$ IMMUTABLE STRICT LANGUAGE SQL;

-- SUBSTRING_INDEX()
CREATE OR REPLACE FUNCTION substring_index(text, text, integer)
RETURNS text AS $$
  DECLARE
    tokens text[];
  BEGIN
    tokens := pg_catalog.string_to_array($1, $2); 

    IF $3 >= 0 THEN
      RETURN pg_catalog.array_to_string(tokens[1:$3], $2);
    ELSE
      RETURN pg_catalog.array_to_string(tokens[($3 * -1):pg_catalog.array_upper(tokens, 1)], $2);
    END IF;
  END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

-- STRCMP()
-- Note: comparison is case-sensitive
CREATE OR REPLACE FUNCTION strcmp(text, text)
RETURNS integer AS $$
  SELECT CASE
    WHEN $1 = $2 THEN 0
    WHEN $1 < $2 THEN -1
    ELSE 1
  END
$$ IMMUTABLE STRICT LANGUAGE SQL;

-- UCASE()
CREATE OR REPLACE FUNCTION ucase(text)
RETURNS text AS $$
  SELECT pg_catalog.upper($1)
$$ IMMUTABLE STRICT LANGUAGE SQL;

-- UNCOMPRESS()
-- Not implemented.

-- UNHEX()
-- Depends on: CONV()
CREATE OR REPLACE FUNCTION unhex(text)
RETURNS text AS $$
  DECLARE
    len integer := pg_catalog.length($1);
    temp text := '';
    i int := 1;
  BEGIN
    WHILE i <= len LOOP
      temp := temp operator(pg_catalog.||) pg_catalog.chr(conv(substring($1 from i for 2), 16, 10)::integer);
      i := i + 2;
    END LOOP;
    RETURN temp; 
  END;
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;
