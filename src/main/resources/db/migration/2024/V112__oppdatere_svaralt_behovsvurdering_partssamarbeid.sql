-- Deaktiver 'Partssamarbeid' med temaId 13
UPDATE ia_sak_kartlegging_tema
SET status = 'INAKTIV'
WHERE tema_id = 13;

-- Nytt tema -> 'Partssamarbeid'
INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, status, rekkefolge, type)
VALUES (19, 'Partssamarbeid', 'AKTIV', 1, 'Behovsvurdering');

-- Nytt undertema -> 'Partssamarbeid' : 'Partssamarbeid'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (30, 'Partssamarbeid', 'AKTIV', 1, 19, false);

-- Nytt spørsmål for undertema -> 'Partssamarbeid' : 'Partssamarbeid'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01939c06-422b-7213-930c-4571292085f5',
        'Vi planlegger og gjennomfører jevnlige møter i partssamarbeidet',
        false);
-- Knytt spørsmål til undertema -> 'Partssamarbeid'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (30, '01939c06-422b-7213-930c-4571292085f5', 1);
-- Knytt tema til spørsmål -> 'Partssamarbeid'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (19, '01939c06-422b-7213-930c-4571292085f5');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01939c07-36be-70f1-b3e3-5ef094f6690c', '01939c06-422b-7213-930c-4571292085f5', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01939c07-526c-73f0-b8a6-f565691ded05', '01939c06-422b-7213-930c-4571292085f5', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01939c07-6c97-7964-93d9-0aa0a3a9e734', '01939c06-422b-7213-930c-4571292085f5', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01939c07-a5b3-732d-8e4e-760f6fd475ad', '01939c06-422b-7213-930c-4571292085f5', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01939c07-c984-7976-a8c8-05778c9635e0', '01939c06-422b-7213-930c-4571292085f5', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Partssamarbeid' : 'Partssamarbeid'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01939c0b-21f2-728d-aa91-3c84fef3bb18',
        'Hvilke temaer vektlegges mest i møtene?',
        true);
-- Knytt spørsmål til undertema -> 'Partssamarbeid'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (30, '01939c0b-21f2-728d-aa91-3c84fef3bb18', 2);

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01939c0b-3ddb-770c-a48b-69df4a902044', '01939c0b-21f2-728d-aa91-3c84fef3bb18', 'Lønnsforhandlinger');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01939c0b-4ccc-72f5-8927-378d67cd6a7a', '01939c0b-21f2-728d-aa91-3c84fef3bb18', 'HMS');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01939c0b-6079-7082-8b94-8457ec89a59d', '01939c0b-21f2-728d-aa91-3c84fef3bb18', 'Drift og bemanning');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01939c0b-7a52-7cbc-a637-8c7dfdbe16f8', '01939c0b-21f2-728d-aa91-3c84fef3bb18', 'Sykefravær (f.eks. rutiner, tilrettelegging, oppfølging)');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01939c0b-939d-7a8a-804e-d95a2dc57d3c', '01939c0b-21f2-728d-aa91-3c84fef3bb18', 'Arbeidsmiljø (f.eks. organisering, planlegging)');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01939c0b-a78b-74f7-9ec0-5203241621cd', '01939c0b-21f2-728d-aa91-3c84fef3bb18', 'Personalpolitikk');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01939c0b-faea-7833-a622-d401d7a75202', '01939c0b-21f2-728d-aa91-3c84fef3bb18', 'Velferdsgoder');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01939c0c-1538-748c-8b7a-c47a4435b959', '01939c0b-21f2-728d-aa91-3c84fef3bb18', 'Annet');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01939c0c-2f3c-77a5-9e83-a6bee6db10e9', '01939c0b-21f2-728d-aa91-3c84fef3bb18', 'Vet ikke ');

-- Nytt spørsmål for undertema -> 'Partssamarbeid' : 'Partssamarbeid'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01939c14-7280-75a7-aeb6-dcab9e11c906',
        'Hvordan opplever du at partssamarbeidet fungerer?',
        false);
-- Knytt spørsmål til undertema -> 'Partssamarbeid'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (30, '01939c14-7280-75a7-aeb6-dcab9e11c906', 3);


-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01939c14-b530-7469-9ad3-b749339b313b', '01939c14-7280-75a7-aeb6-dcab9e11c906', 'Svært bra');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01939c14-c972-729f-b17f-92f4960ada31', '01939c14-7280-75a7-aeb6-dcab9e11c906', 'Bra');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01939c14-dc4c-71cb-b5a1-dd5618d99191', '01939c14-7280-75a7-aeb6-dcab9e11c906', 'Dårlig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01939c14-ed0c-70e2-9a9e-ed509fd3c796', '01939c14-7280-75a7-aeb6-dcab9e11c906', 'Svært dårlig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01939c14-fbb4-7292-9a3d-32382c9b1d44', '01939c14-7280-75a7-aeb6-dcab9e11c906', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Partssamarbeid' : 'Partssamarbeid'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01939c1a-da7e-7600-ad4e-6d27c5e6fe5a',
        'Som leder, tillitsvalgt eller verneombud har jeg god forståelse av min rolle og mine ansvarsområder i partssamarbeidet',
        false);
-- Knytt spørsmål til undertema -> 'Partssamarbeid'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (30, '01939c1a-da7e-7600-ad4e-6d27c5e6fe5a', 4);

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01939c1b-1fc8-74c7-aba7-2cab04053f4d', '01939c1a-da7e-7600-ad4e-6d27c5e6fe5a', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01939c1b-3124-74e0-b65e-bf5707ceafde', '01939c1a-da7e-7600-ad4e-6d27c5e6fe5a', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01939c1b-4074-7c20-b1dd-8833829bf028', '01939c1a-da7e-7600-ad4e-6d27c5e6fe5a', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01939c1b-529d-70a3-b7c6-59be80b6003e', '01939c1a-da7e-7600-ad4e-6d27c5e6fe5a', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01939c1c-5da9-7988-92b6-006015ab27d8', '01939c1a-da7e-7600-ad4e-6d27c5e6fe5a', 'Vet ikke');
