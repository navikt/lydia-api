-- Deaktiver gamelt tema ARBEIDSMILJØ med temaId 6
UPDATE ia_sak_kartlegging_tema
SET status = 'INAKTIV'
WHERE tema_id = 6;

-- Legg til ny versjon av Arbeidsmiljø
INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, status, rekkefolge, type)
VALUES (12, 'Arbeidsmiljø', 'AKTIV', 3, 'Behovsvurdering');

-- spm 1 Arbeidsmiljø
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01932fb8-64f1-76fa-ad12-0494a47f3008',
        'Vi er kjent med de vanlige risikofaktorene i bransjen vår',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fb8-64f1-76fa-ad12-0494a47f3008', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fb8-64f1-76fa-ad12-0494a47f3008', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fb8-64f1-76fa-ad12-0494a47f3008', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fb8-64f1-76fa-ad12-0494a47f3008', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fb8-64f1-76fa-ad12-0494a47f3008', 'Vet ikke');

-- spm 2 Arbeidsmiljø
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01932fba-703f-776f-a3aa-4d1c4cd2a5e0',
        'Vi har nødvendig kompetanse for å gjøre tiltak for å forbedre arbeidsmiljøet',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fba-703f-776f-a3aa-4d1c4cd2a5e0', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fba-703f-776f-a3aa-4d1c4cd2a5e0', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fba-703f-776f-a3aa-4d1c4cd2a5e0', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fba-703f-776f-a3aa-4d1c4cd2a5e0', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fba-703f-776f-a3aa-4d1c4cd2a5e0', 'Vet ikke');

-- spm 3 Arbeidsmiljø
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01932fbb-9e2a-72d0-b759-190792c3ea7f',
        'Vi jobber systematisk med utvikling av arbeidsmiljøet vårt',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fbb-9e2a-72d0-b759-190792c3ea7f', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fbb-9e2a-72d0-b759-190792c3ea7f', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fbb-9e2a-72d0-b759-190792c3ea7f', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fbb-9e2a-72d0-b759-190792c3ea7f', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fbb-9e2a-72d0-b759-190792c3ea7f', 'Vet ikke');

-- spm 4 Arbeidsmiljø
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01932fbc-ef2d-7980-af65-69a04cade53d',
        'På arbeidsplassen vår blir ansatte med psykiske plager godt ivaretatt',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fbc-ef2d-7980-af65-69a04cade53d', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fbc-ef2d-7980-af65-69a04cade53d', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fbc-ef2d-7980-af65-69a04cade53d', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fbc-ef2d-7980-af65-69a04cade53d', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fbc-ef2d-7980-af65-69a04cade53d', 'Vet ikke');

-- Legg til alle 4 spm i tema Arbeidsmiljø
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (12, '01932fb8-64f1-76fa-ad12-0494a47f3008');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (12, '01932fba-703f-776f-a3aa-4d1c4cd2a5e0');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (12, '01932fbb-9e2a-72d0-b759-190792c3ea7f');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (12, '01932fbc-ef2d-7980-af65-69a04cade53d');
