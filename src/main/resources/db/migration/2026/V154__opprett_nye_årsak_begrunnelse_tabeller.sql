CREATE TABLE hendelse_aarsak
(
    aarsak_id   varchar not null primary key,
    hendelse_id varchar not null unique references ia_sak_hendelse (id),
    aarsak_enum varchar not null,
    aarsak      varchar not null
);

CREATE TABLE aarsak_begrunnelse
(
    aarsak_id        varchar not null references hendelse_aarsak (aarsak_id),
    begrunnelse_enum varchar not null,
    begrunnelse      varchar not null,
    CONSTRAINT begrunnelse_mengde UNIQUE (aarsak_id, begrunnelse_enum)
);

-- Før vi får begynt å generere aarsak_id i kode, bruk hendelse_id da det skal være maks én aarsak per hendelse i dag
-- NB: For å unngå glipper i data, må kodeoppdatering på insert oppdateres til å legge i begge tabeller samtidig som
-- denne endringen trer i kraft
INSERT INTO hendelse_aarsak (aarsak_id, hendelse_id, aarsak_enum, aarsak)
SELECT DISTINCT hendelse_id AS aarsak_id, hendelse_id, aarsak_enum, aarsak
FROM hendelse_begrunnelse
ON CONFLICT DO NOTHING ;

INSERT INTO aarsak_begrunnelse (aarsak_id, begrunnelse_enum, begrunnelse)
SELECT DISTINCT hendelse_id AS aarsak_id, begrunnelse_enum, begrunnelse
FROM hendelse_begrunnelse
ON CONFLICT DO NOTHING ;
