ALTER TABLE dokument_til_publisering add column ia_prosess int;

UPDATE dokument_til_publisering
    SET ia_prosess = (SELECT ia_prosess FROM ia_sak_kartlegging WHERE kartlegging_id = referanse_id);

ALTER TABLE dokument_til_publisering
    ALTER COLUMN ia_prosess SET NOT NULL;

ALTER TABLE dokument_til_publisering
    ADD CONSTRAINT dokument_til_publisering_ia_prosess_fk FOREIGN KEY (ia_prosess) REFERENCES ia_prosess(id);