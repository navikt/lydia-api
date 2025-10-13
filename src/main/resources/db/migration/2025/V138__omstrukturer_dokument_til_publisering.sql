-- Opprett ny tabell
CREATE TABLE kvittert_dokument
(
    dokument_id             varchar(36) PRIMARY KEY,
    ia_prosess              int NOT NULL REFERENCES ia_prosess(id),
    referanse_id            varchar(36) NOT NULL,
    type                    varchar NOT NULL,
    status                  varchar NOT NULL,
    publisert_tidspunkt     timestamp,
    journalpost_id          varchar,
    kvittert_tidspunkt      timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Migrer fra gammel struktur
INSERT INTO kvittert_dokument
(
    SELECT dokument_id, ia_prosess, referanse_id, type, status, publisert, journalpost_id, publisert
    FROM dokument_til_publisering
    WHERE status = 'PUBLISERT'
);

-- Rydd opp
DELETE FROM dokument_til_publisering WHERE status = 'PUBLISERT';
ALTER TABLE dokument_til_publisering
    DROP COLUMN dokument_id,
    DROP COLUMN status,
    DROP COLUMN publisert,
    DROP CONSTRAINT dokument_til_publisering_ia_prosess_fk,
    DROP COLUMN ia_prosess,
    DROP COLUMN journalpost_id;