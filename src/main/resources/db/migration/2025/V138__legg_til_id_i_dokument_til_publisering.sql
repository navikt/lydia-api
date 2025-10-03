ALTER TABLE dokument_til_publisering
    ADD COLUMN id SERIAL,
    DROP CONSTRAINT dokument_til_publisering_pkey,
    ADD PRIMARY KEY (id);
