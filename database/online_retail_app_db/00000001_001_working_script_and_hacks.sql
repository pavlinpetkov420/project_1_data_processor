SELECT * FROM pg_catalog.pg_constraint
where substr(conname, 1, 2) <> 'pg';

select * from information_schema.tables
where table_schema not in ('information_schema', 'pg_catalog');


-- Return All constraints tied to table name out of system schemas in Database
SELECT
    con.conname AS constraint_name,
    con.contype AS constraint_type,
    conrel.relname AS table_name,
    a.attname AS column_name,
    nsp.nspname AS schema_name,
    pgc.relname AS referenced_table,
    pga.attname AS referenced_column
FROM
    pg_constraint con
    JOIN pg_class conrel ON con.conrelid = conrel.oid
    JOIN pg_namespace nsp ON conrel.relnamespace = nsp.oid
    LEFT JOIN pg_attribute a ON a.attnum = ANY(con.conkey) AND a.attrelid = conrel.oid
    LEFT JOIN pg_class pgc ON con.confrelid = pgc.oid
    LEFT JOIN pg_attribute pga ON pga.attnum = ANY(con.confkey) AND pga.attrelid = pgc.oid
WHERE
    nsp.nspname NOT IN ('pg_catalog', 'information_schema')
ORDER BY
    schema_name, table_name, constraint_name;
