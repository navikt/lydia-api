-- Deaktiver 'Arbeidsmiljø' med temaId 15
UPDATE ia_sak_kartlegging_tema
SET status = 'INAKTIV'
WHERE tema_id = 15;

-- Nytt tema -> 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, status, rekkefolge, type)
VALUES (21, 'Arbeidsmiljø', 'AKTIV', 3, 'Behovsvurdering');

-- Nytt undertema -> 'Arbeidsmiljø' : 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (32, 'Arbeidsmiljø', 'AKTIV', 1, 21, false);

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0193aae2-0875-7e3e-87a5-1ec0f99ae9dc',
        'Vi er kjent med de vanlige risikofaktorene i bransjen vår',
        false);
-- Knytt spørsmål til undertema -> 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (32, '0193aae2-0875-7e3e-87a5-1ec0f99ae9dc', 1);

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aae3-55ce-7833-a589-7222bdb6e961', '0193aae2-0875-7e3e-87a5-1ec0f99ae9dc', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aae3-6b94-76f3-9eb4-e91bea1c7481', '0193aae2-0875-7e3e-87a5-1ec0f99ae9dc', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aae3-7bbc-7868-9d3d-345f03557ed3', '0193aae2-0875-7e3e-87a5-1ec0f99ae9dc', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aae3-8f66-7da3-8726-3b6b4ff275f7', '0193aae2-0875-7e3e-87a5-1ec0f99ae9dc', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aae3-b6bb-752e-b284-30ae8522f2e0', '0193aae2-0875-7e3e-87a5-1ec0f99ae9dc', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0193aae3-ce58-7124-a054-53e883346e4c',
        'Vi har nødvendig kompetanse for å gjøre tiltak for å forbedre arbeidsmiljøet',
        false);
-- Knytt spørsmål til undertema -> 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (32, '0193aae3-ce58-7124-a054-53e883346e4c', 2);

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aae3-f729-7392-8e45-def38515c51e', '0193aae3-ce58-7124-a054-53e883346e4c', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aae4-0c49-7fb1-8b4a-f162ff68aa6c', '0193aae3-ce58-7124-a054-53e883346e4c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aae4-20a3-7960-88c0-1b6749cc11f8', '0193aae3-ce58-7124-a054-53e883346e4c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aae4-32e0-7bc0-953c-190d8ee71f32', '0193aae3-ce58-7124-a054-53e883346e4c', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aae4-4363-7dc8-8615-c223177b36a1', '0193aae3-ce58-7124-a054-53e883346e4c', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0193aae6-355d-7dca-901a-8c9d54033626',
        'Vi jobber systematisk med utvikling av arbeidsmiljøet vårt',
        false);
-- Knytt spørsmål til undertema -> 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (32, '0193aae6-355d-7dca-901a-8c9d54033626', 3);

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aae6-4712-7de8-a55f-aefa8de9d0b3', '0193aae6-355d-7dca-901a-8c9d54033626', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aae6-5c14-741d-903b-40c85f5d3014', '0193aae6-355d-7dca-901a-8c9d54033626', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aae6-6ae3-7c27-be4c-50f3f10f7eb8', '0193aae6-355d-7dca-901a-8c9d54033626', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aae6-7bda-7cc7-916e-5a1481e948ee', '0193aae6-355d-7dca-901a-8c9d54033626', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aae6-a154-7b93-9879-4d68f19b2b4a', '0193aae6-355d-7dca-901a-8c9d54033626', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0193aae6-b9aa-7ae9-ac0b-4abd3c2c9e70',
        'På arbeidsplassen vår blir ansatte med psykiske plager godt ivaretatt',
        false);
-- Knytt spørsmål til undertema -> 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (32, '0193aae6-b9aa-7ae9-ac0b-4abd3c2c9e70', 4);

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aae6-d01b-701b-bea6-3f1a3d1d29af', '0193aae6-b9aa-7ae9-ac0b-4abd3c2c9e70', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aae6-e40b-76db-93c0-beac249db061', '0193aae6-b9aa-7ae9-ac0b-4abd3c2c9e70', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aae6-f30d-7c8d-8fb5-f0d401d28b32', '0193aae6-b9aa-7ae9-ac0b-4abd3c2c9e70', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aae7-0dd1-7d14-aa9d-f050add4972e', '0193aae6-b9aa-7ae9-ac0b-4abd3c2c9e70', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aae7-252f-76f2-9252-a4b02ad4536d', '0193aae6-b9aa-7ae9-ac0b-4abd3c2c9e70', 'Vet ikke');