/* note: for this to work any literals must be enclosed in single quotes */
/* otherwise they will be treated as column names, thus causing an error */

create or replace function concat(text,text) returns text as
'select $1 || $2' language sql strict immutable;

create or replace function concat(text,text,text) returns text as
'select $1 || $2 || $3' language sql strict immutable;

create or replace function concat(text,text,text,text) returns text as
'select $1 || $2 || $3 || $4' language sql strict immutable;

create or replace function concat(text,text,text,text,text) returns text as
'select $1 || $2 || $3 || $4 || $5' language sql strict immutable;
