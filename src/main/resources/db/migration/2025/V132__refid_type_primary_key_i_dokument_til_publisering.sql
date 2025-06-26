-- Gjør (referanse_id, type) primærnøkkel
ALTER TABLE dokument_til_publisering DROP CONSTRAINT dokument_til_publisering_pkey;
ALTER TABLE dokument_til_publisering ADD PRIMARY KEY (referanse_id, type);
ALTER TABLE dokument_til_publisering alter column dokument_id drop not null;
