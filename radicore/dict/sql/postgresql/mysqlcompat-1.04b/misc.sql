-- INET_ATON()
-- Credit: Michael Fuhr
CREATE OR REPLACE FUNCTION inet_aton(text)
RETURNS bigint AS $$
  DECLARE
      a text[];
      b text[4];
      up int;
      family int;
      i int;
  BEGIN
      IF position(':' in $1) > 0 THEN
        family = 6;
      ELSE
        family = 4;
      END IF;
      -- mysql doesn't support IPv6 yet, it seems
      IF family = 6 THEN
        RETURN NULL;
      END IF;
      a = pg_catalog.string_to_array($1, '.');
      up = array_upper(a, 1);
      IF up = 4 THEN
        -- nothing to do
        b = a;
      ELSIF up = 3 THEN
        -- 127.1.2 = 127.1.0.2
        b = array[a[1], a[2], '0', a[3]];
      ELSIF up = 2 THEN
        -- 127.1 = 127.0.0.1
        b = array[a[1], '0', '0', a[2]];
      ELSIF up = 1 THEN
        -- 127 = 0.0.0.127
        b = array['0', '0', '0', a[1]];
      END IF;
      i = 1;
      -- handle 127..1
      WHILE i <= 4 LOOP
        IF length(b[i]) = 0 THEN
          b[i] = '0';
        END IF;
        i = i + 1;
      END LOOP;
      RETURN (b[1]::bigint << 24) | (b[2]::bigint << 16) |
              (b[3]::bigint << 8) | b[4]::bigint;
  END
$$ IMMUTABLE STRICT LANGUAGE PLPGSQL;

-- INET_NTOA()
-- done in SQL to take advantage of inlining
CREATE OR REPLACE FUNCTION inet_ntoa(bigint)
RETURNS text AS $$
SELECT CASE WHEN $1 > 4294967295 THEN NULL ELSE
    ((($1::bigint >> 24) % 256) + 256) % 256 operator(pg_catalog.||) '.' operator(pg_catalog.||)
    ((($1::bigint >> 16) % 256) + 256) % 256 operator(pg_catalog.||) '.' operator(pg_catalog.||)
    ((($1::bigint >>  8) % 256) + 256) % 256 operator(pg_catalog.||) '.' operator(pg_catalog.||)
    ((($1::bigint      ) % 256) + 256) % 256 END;
$$ IMMUTABLE STRICT LANGUAGE SQL;

-- SLEEP()
CREATE OR REPLACE FUNCTION sleep(float)
RETURNS integer AS $$
  BEGIN
    IF $1 > 0 THEN
      WHILE pg_catalog.timeofday()::timestamp < (current_timestamp + interval '1 second' * $1) LOOP
      -- Do nothing
      END LOOP;
    END IF;
    RETURN 0;
  END
$$ STRICT VOLATILE LANGUAGE PLPGSQL;
