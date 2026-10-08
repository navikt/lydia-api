-- Før vi får begynt å generere aarsak_id i kode, bruk hendelse_id da det skal være maks én aarsak per hendelse i dag
-- NB: For å unngå glipper i data, må kodeoppdatering på insert oppdateres til å legge i begge tabeller samtidig som
-- denne endringen trer i kraft
INSERT INTO hendelse_aarsak (id, hendelse_id, aarsak_enum, aarsak)
SELECT DISTINCT hendelse_id AS id, hendelse_id, aarsak_enum, aarsak
FROM hendelse_begrunnelse
ON CONFLICT DO NOTHING ;

INSERT INTO aarsak_begrunnelse (aarsak_id, begrunnelse_enum, begrunnelse)
SELECT DISTINCT hendelse_id AS aarsak_id, begrunnelse_enum, begrunnelse
FROM hendelse_begrunnelse
ON CONFLICT DO NOTHING ;
