ALTER TABLE ia_prosess
ADD COLUMN nav_enhet_nummer VARCHAR;

UPDATE ia_prosess
SET nav_enhet_nummer = ish.nav_enhet_nummer
FROM ia_sak_hendelse ish
INNER JOIN hendelser_til_samarbeid hts ON ish.id = hts.hendelse_id
WHERE type = 'NY_PROSESS'
AND ia_prosess.id = hts.samarbeid_id;
