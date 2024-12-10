-- Deaktiver undertemaer til tema 'Partssamarbeid' med temaId 13
UPDATE ia_sak_kartlegging_undertema
SET status = 'INAKTIV'
WHERE tema_id = 13;

-- Deaktiver undertemaer til tema 'Sykefraværsarbeid' med temaId 14
UPDATE ia_sak_kartlegging_undertema
SET status = 'INAKTIV'
WHERE tema_id = 14;

-- Deaktiver undertemaer til tema 'Arbeidsmiljø' med temaId 15
UPDATE ia_sak_kartlegging_undertema
SET status = 'INAKTIV'
WHERE tema_id = 15;
