-- ${flyway:timestamp}

DO $$
    BEGIN
        CREATE ROLE cloudsqliamuser WITH NOLOGIN;
    EXCEPTION WHEN DUPLICATE_OBJECT THEN
        RAISE NOTICE 'not creating role cloudsqliamuser -- it already exists';
    END
$$;

grant all on all tables in schema public to cloudsqliamuser;
grant all on all sequences in schema public to cloudsqliamuser;