-- Gjør tema inaktivt
UPDATE ia_sak_kartlegging_tema
SET status = 'INAKTIV'
WHERE tema_id = 16;
-- Gjør undertemaer til temaet 16 inaktivt
UPDATE ia_sak_kartlegging_undertema
SET status = 'INAKTIV'
WHERE tema_id = 16;

-- Gjør tema inaktivt
UPDATE ia_sak_kartlegging_tema
SET status = 'INAKTIV'
WHERE tema_id = 17;
-- Gjør undertemaer til temaet 17 inaktivt
UPDATE ia_sak_kartlegging_undertema
SET status = 'INAKTIV'
WHERE tema_id = 17;

-- Gjør tema inaktivt
UPDATE ia_sak_kartlegging_tema
SET status = 'INAKTIV'
WHERE tema_id = 18;
-- Gjør undertemaer til temaet 18 inaktivt
UPDATE ia_sak_kartlegging_undertema
SET status = 'INAKTIV'
WHERE tema_id = 18;


-- Nytt tema -> 'Partssamarbeid'
INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, status, rekkefolge, type)
VALUES (22, 'Partssamarbeid', 'AKTIV', 1, 'Evaluering');

-- Nytt undertema -> 'Partssamarbeid' : 'Utvikle partssamarbeidet'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (33, 'Utvikle partssamarbeidet', 'AKTIV', 1, 22, false);

-- Nytt spørsmål for undertema -> 'Partssamarbeid' : 'Utvikle partssamarbeidet'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570ba-f88e-76f2-8000-ad3bff9ce33c',
        'Hvordan opplever du at partssamarbeidet har utviklet seg i løpet av samarbeidsperioden?', false);
-- Knytt spørsmål til undertema -> 'Utvikle partssamarbeidet'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (33, '067570ba-f88e-76f2-8000-ad3bff9ce33c', 1);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-f8c1-7db0-8000-56c8968c8b45', '067570ba-f88e-76f2-8000-ad3bff9ce33c', 'Svært godt');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-f8f5-747e-8000-872651781035', '067570ba-f88e-76f2-8000-ad3bff9ce33c', 'Godt');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-f928-7b4b-8000-c6f8e4091ea7', '067570ba-f88e-76f2-8000-ad3bff9ce33c', 'Dårlig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-f95c-70db-8000-9d4189f58792', '067570ba-f88e-76f2-8000-ad3bff9ce33c', 'Svært dårlig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-f98f-76be-8000-2d387b1a43c6', '067570ba-f88e-76f2-8000-ad3bff9ce33c', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Partssamarbeid' : 'Utvikle partssamarbeidet'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570ba-f9be-75c9-8000-4267d01198b0',
        'Som leder, tillitsvalgt eller verneombud har jeg fått en bedre forståelse av min rolle og mine ansvarsområder i partssamarbeidet',
        false);
-- Knytt spørsmål til undertema -> 'Utvikle partssamarbeidet'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (33, '067570ba-f9be-75c9-8000-4267d01198b0', 2);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-f9f1-7bde-8000-9946ec7e9299', '067570ba-f9be-75c9-8000-4267d01198b0', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-fa1f-7080-8000-49a5457d0032', '067570ba-f9be-75c9-8000-4267d01198b0', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-fa4f-7c61-8000-08008193e093', '067570ba-f9be-75c9-8000-4267d01198b0', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-fa82-71e1-8000-9cef3314e9e8', '067570ba-f9be-75c9-8000-4267d01198b0', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-fab5-7c9e-8000-3528cdbe0d07', '067570ba-f9be-75c9-8000-4267d01198b0', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Partssamarbeid' : 'Utvikle partssamarbeidet'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570ba-fae8-7d97-8000-dab5975f7891',
        'Vi har opparbeidet oss nødvendig kompetanse for å forebygge og håndtere sykefraværet vårt', false);
-- Knytt spørsmål til undertema -> 'Utvikle partssamarbeidet'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (33, '067570ba-fae8-7d97-8000-dab5975f7891', 3);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-fb1c-7875-8000-5780a886be5f', '067570ba-fae8-7d97-8000-dab5975f7891', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-fb4d-7551-8000-8c9c50067a2e', '067570ba-fae8-7d97-8000-dab5975f7891', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-fb80-7ebe-8000-69ee49efbece', '067570ba-fae8-7d97-8000-dab5975f7891', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-fbac-711a-8000-cae2b10ee8e0', '067570ba-fae8-7d97-8000-dab5975f7891', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-fbda-706a-8000-c66ae366e828', '067570ba-fae8-7d97-8000-dab5975f7891', 'Vet ikke');


-- Nytt undertema -> 'Partssamarbeid' : 'Veien videre'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (34, 'Veien videre', 'AKTIV', 2, 22, true);

-- Nytt spørsmål for undertema -> 'Partssamarbeid' : 'Veien videre'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570ba-fc0b-7cf0-8000-fdb8d6554b95',
        'Vi har laget konkrete planer for hvordan vi i partssamarbeidet skal jobbe fremover', false);
-- Knytt spørsmål til undertema -> 'Veien videre'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (34, '067570ba-fc0b-7cf0-8000-fdb8d6554b95', 1);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-fc3d-7987-8000-4a445b35c73e', '067570ba-fc0b-7cf0-8000-fdb8d6554b95', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-fc6d-7256-8000-3c3a1d5decdc', '067570ba-fc0b-7cf0-8000-fdb8d6554b95', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-fc96-7cb5-8000-2569ccc905a0', '067570ba-fc0b-7cf0-8000-fdb8d6554b95', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-fcc8-7398-8000-cf8e3cc683a4', '067570ba-fc0b-7cf0-8000-fdb8d6554b95', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-fcfc-7297-8000-970d9c99996a', '067570ba-fc0b-7cf0-8000-fdb8d6554b95', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Partssamarbeid' : 'Veien videre'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570ba-fd29-7856-8000-72a8b3e85d12',
        'Jeg opplever at vi er motiverte for å samarbeide videre om sykefravær og arbeidsmiljø', false);
-- Knytt spørsmål til undertema -> 'Veien videre'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (34, '067570ba-fd29-7856-8000-72a8b3e85d12', 2);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-fd54-7db5-8000-4a0d2abae6b7', '067570ba-fd29-7856-8000-72a8b3e85d12', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-fd86-7162-8000-a4e277a12864', '067570ba-fd29-7856-8000-72a8b3e85d12', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-fdb9-7abf-8000-4210afebed88', '067570ba-fd29-7856-8000-72a8b3e85d12', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-fded-7677-8000-c0aacc4cb237', '067570ba-fd29-7856-8000-72a8b3e85d12', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-fe1e-7ff9-8000-89f7a4f4751e', '067570ba-fd29-7856-8000-72a8b3e85d12', 'Vet ikke');


-- Nytt tema -> 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, status, rekkefolge, type)
VALUES (23, 'Sykefraværsarbeid', 'AKTIV', 2, 'Evaluering');

-- Nytt undertema -> 'Sykefraværsarbeid' : 'Sykefraværsrutiner'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (35, 'Sykefraværsrutiner', 'AKTIV', 1, 23, false);

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Sykefraværsrutiner'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570ba-fe49-715b-8000-f26df51c9dd0', 'Vi jobber nå mer systematisk for å forebygge sykefraværet vårt',
        false);
-- Knytt spørsmål til undertema -> 'Sykefraværsrutiner'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (35, '067570ba-fe49-715b-8000-f26df51c9dd0', 1);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-fe74-7f2f-8000-e3a2440c9223', '067570ba-fe49-715b-8000-f26df51c9dd0', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-fe9f-797a-8000-aa36accd0bea', '067570ba-fe49-715b-8000-f26df51c9dd0', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-fed3-70ad-8000-5aa661e92edf', '067570ba-fe49-715b-8000-f26df51c9dd0', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-ff05-7b5b-8000-19412ee71098', '067570ba-fe49-715b-8000-f26df51c9dd0', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-ff34-7dce-8000-ed8bdbde43b9', '067570ba-fe49-715b-8000-f26df51c9dd0', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Sykefraværsrutiner'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570ba-ff68-771a-8000-94ad7dc52f81', 'Vi har godt etablerte og lett tilgjengelige sykefraværsrutiner',
        false);
-- Knytt spørsmål til undertema -> 'Sykefraværsrutiner'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (35, '067570ba-ff68-771a-8000-94ad7dc52f81', 2);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-ff9c-7209-8000-e6147a7f391e', '067570ba-ff68-771a-8000-94ad7dc52f81', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-ffc7-725c-8000-e463a77fd4e9', '067570ba-ff68-771a-8000-94ad7dc52f81', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570ba-fffa-79f3-8000-52204b69f2cf', '067570ba-ff68-771a-8000-94ad7dc52f81', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-002e-7019-8000-d4f5a618cf3c', '067570ba-ff68-771a-8000-94ad7dc52f81', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-005f-74a1-8000-e623828091a0', '067570ba-ff68-771a-8000-94ad7dc52f81', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Sykefraværsrutiner'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570bb-008f-7c93-8000-7522a61ae630',
        'Ansatte kjenner til egne plikter og rettigheter når de er sykmeldt eller står i fare for å bli det', false);
-- Knytt spørsmål til undertema -> 'Sykefraværsrutiner'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (35, '067570bb-008f-7c93-8000-7522a61ae630', 3);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-00c2-7f51-8000-13b252e41fda', '067570bb-008f-7c93-8000-7522a61ae630', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-00f6-79ca-8000-e26c4d3f5c99', '067570bb-008f-7c93-8000-7522a61ae630', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0128-7672-8000-4bb28914408c', '067570bb-008f-7c93-8000-7522a61ae630', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-015b-7142-8000-dd68a73ee8a4', '067570bb-008f-7c93-8000-7522a61ae630', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-018a-71df-8000-657e71e923ca', '067570bb-008f-7c93-8000-7522a61ae630', 'Vet ikke');


-- Nytt undertema -> 'Sykefraværsarbeid' : 'Oppfølgingssamtaler'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (36, 'Oppfølgingssamtaler', 'AKTIV', 2, 23, false);

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Oppfølgingssamtaler'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570bb-01ba-7ade-8000-7d642ef04075',
        'Jeg opplever at ledere er trygge under oppfølgingsamtaler med ansatte som er sykmeldt eller står i fare for å bli det',
        false);
-- Knytt spørsmål til undertema -> 'Oppfølgingssamtaler'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (36, '067570bb-01ba-7ade-8000-7d642ef04075', 1);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-01e6-785d-8000-3260670da3d3', '067570bb-01ba-7ade-8000-7d642ef04075', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0215-7475-8000-3f7667d55c38', '067570bb-01ba-7ade-8000-7d642ef04075', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0240-7da1-8000-6d809586c9aa', '067570bb-01ba-7ade-8000-7d642ef04075', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-026b-74e9-8000-3089194d0410', '067570bb-01ba-7ade-8000-7d642ef04075', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-029e-7e78-8000-b126337131ef', '067570bb-01ba-7ade-8000-7d642ef04075', 'Vet ikke');


-- Nytt undertema -> 'Sykefraværsarbeid' : 'Tilretteleggings- og medvirkningsplikt'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (37, 'Tilretteleggings- og medvirkningsplikt', 'AKTIV', 3, 23, false);

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Tilretteleggings- og medvirkningsplikt'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570bb-02d2-7a0e-8000-d2ea1fcce27c',
        'Vi har utarbeidet og tilgjengeliggjort en oversikt over våre tilretteleggingsmuligheter', false);
-- Knytt spørsmål til undertema -> 'Tilretteleggings- og medvirkningsplikt'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (37, '067570bb-02d2-7a0e-8000-d2ea1fcce27c', 1);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0306-74fd-8000-06f8ee5c000f', '067570bb-02d2-7a0e-8000-d2ea1fcce27c', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0332-7f12-8000-f4fc9fb45930', '067570bb-02d2-7a0e-8000-d2ea1fcce27c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0366-78b1-8000-aa8e37a35df0', '067570bb-02d2-7a0e-8000-d2ea1fcce27c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0394-73bf-8000-a10410cfc3e4', '067570bb-02d2-7a0e-8000-d2ea1fcce27c', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-03c7-7768-8000-b3db5284d128', '067570bb-02d2-7a0e-8000-d2ea1fcce27c', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Tilretteleggings- og medvirkningsplikt'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570bb-03f9-7db2-8000-a9655fa71596',
        'Vi har etablerte rutiner og god kultur for tilrettelegging for ansatte', false);
-- Knytt spørsmål til undertema -> 'Tilretteleggings- og medvirkningsplikt'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (37, '067570bb-03f9-7db2-8000-a9655fa71596', 2);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0429-7153-8000-752fd126946d', '067570bb-03f9-7db2-8000-a9655fa71596', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0459-785a-8000-cff3dc163bf4', '067570bb-03f9-7db2-8000-a9655fa71596', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-048a-703c-8000-dd8ee07e6ecb', '067570bb-03f9-7db2-8000-a9655fa71596', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-04b9-7cc7-8000-c7d31996dcb9', '067570bb-03f9-7db2-8000-a9655fa71596', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-04ed-76dc-8000-dc1a43c9ac18', '067570bb-03f9-7db2-8000-a9655fa71596', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Tilretteleggings- og medvirkningsplikt'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570bb-051b-79e8-8000-237951f8517f', 'Ansatte medvirker under tilrettelegging av arbeidsoppgaver', false);
-- Knytt spørsmål til undertema -> 'Tilretteleggings- og medvirkningsplikt'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (37, '067570bb-051b-79e8-8000-237951f8517f', 3);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0549-7678-8000-6f6bbf0e75da', '067570bb-051b-79e8-8000-237951f8517f', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0578-7f57-8000-113fb96e28ff', '067570bb-051b-79e8-8000-237951f8517f', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-05ac-7aff-8000-c6b33c3e3972', '067570bb-051b-79e8-8000-237951f8517f', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-05db-7307-8000-503fb58bfab8', '067570bb-051b-79e8-8000-237951f8517f', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-060b-7988-8000-62b23b891702', '067570bb-051b-79e8-8000-237951f8517f', 'Vet ikke');


-- Nytt undertema -> 'Sykefraværsarbeid' : 'Sykefravær - enkeltsaker'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (38, 'Sykefravær - enkeltsaker', 'AKTIV', 4, 23, false);

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Sykefravær - enkeltsaker'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570bb-063a-71b1-8000-cf2fc84b132c',
        'Vi har nødvendig kompetanse for å håndtere vanskelige sykefraværssaker', false);
-- Knytt spørsmål til undertema -> 'Sykefravær - enkeltsaker'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (38, '067570bb-063a-71b1-8000-cf2fc84b132c', 1);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0667-76fb-8000-1eeaa40cb4ac', '067570bb-063a-71b1-8000-cf2fc84b132c', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-069a-73d2-8000-a673643c7ea7', '067570bb-063a-71b1-8000-cf2fc84b132c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-06c7-7b45-8000-ae168c3eaf27', '067570bb-063a-71b1-8000-cf2fc84b132c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-06fb-71d0-8000-1bbb3cabdf17', '067570bb-063a-71b1-8000-cf2fc84b132c', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0727-743a-8000-c2b22ece8ab7', '067570bb-063a-71b1-8000-cf2fc84b132c', 'Vet ikke');


-- Nytt undertema -> 'Sykefraværsarbeid' : 'Veien videre'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (39, 'Veien videre', 'AKTIV', 5, 23, true);

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Veien videre'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570bb-0754-7983-8000-0e9465ffec4e',
        'Vi vet hvor vi finner gode verktøy i arbeidet med å redusere sykefraværet vårt', false);
-- Knytt spørsmål til undertema -> 'Veien videre'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (39, '067570bb-0754-7983-8000-0e9465ffec4e', 1);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0788-714d-8000-d8e3fa6dbc50', '067570bb-0754-7983-8000-0e9465ffec4e', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-07b5-7946-8000-354a3f8f5e4f', '067570bb-0754-7983-8000-0e9465ffec4e', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-07e3-7608-8000-a24adb77fb1c', '067570bb-0754-7983-8000-0e9465ffec4e', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0812-7ddb-8000-3e387973a459', '067570bb-0754-7983-8000-0e9465ffec4e', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0844-73c3-8000-386b88a28638', '067570bb-0754-7983-8000-0e9465ffec4e', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Veien videre'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570bb-0871-7897-8000-b3be678d47e5',
        'Jeg tror videre forebyggende sykefraværsarbeid vil bidra til å redusere sykefraværet hos oss', false);
-- Knytt spørsmål til undertema -> 'Veien videre'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (39, '067570bb-0871-7897-8000-b3be678d47e5', 2);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-08a3-751d-8000-642e848eed92', '067570bb-0871-7897-8000-b3be678d47e5', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-08cc-7f9e-8000-2163b835a57c', '067570bb-0871-7897-8000-b3be678d47e5', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-08f8-7eb0-8000-19f6c923c3af', '067570bb-0871-7897-8000-b3be678d47e5', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-092b-7de3-8000-f21b5af93bf3', '067570bb-0871-7897-8000-b3be678d47e5', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-095e-7492-8000-0be8c1e37f55', '067570bb-0871-7897-8000-b3be678d47e5', 'Vet ikke');


-- Nytt tema -> 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, status, rekkefolge, type)
VALUES (24, 'Arbeidsmiljø', 'AKTIV', 3, 'Evaluering');

-- Nytt undertema -> 'Arbeidsmiljø' : 'Utvikle arbeidsmiljøet'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (40, 'Utvikle arbeidsmiljøet', 'AKTIV', 1, 24, false);

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Utvikle arbeidsmiljøet'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570bb-098d-7690-8000-3f59511f38c5',
        'Vi har nå nødvendig kompetanse til å gjøre tiltak og forbedre arbeidsmiljøet vårt', false);
-- Knytt spørsmål til undertema -> 'Utvikle arbeidsmiljøet'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (40, '067570bb-098d-7690-8000-3f59511f38c5', 1);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-09bf-72d3-8000-ce2f5017fc0b', '067570bb-098d-7690-8000-3f59511f38c5', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-09ef-7123-8000-63387e8bc867', '067570bb-098d-7690-8000-3f59511f38c5', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0a1f-73a5-8000-1fab26923eb8', '067570bb-098d-7690-8000-3f59511f38c5', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0a4f-7c1d-8000-5b816b6bc092', '067570bb-098d-7690-8000-3f59511f38c5', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0a81-729c-8000-e2bb2ba92c90', '067570bb-098d-7690-8000-3f59511f38c5', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Utvikle arbeidsmiljøet'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570bb-0aac-7eee-8000-7cea99539721',
        'Vi har utarbeidet konkrete planer for hvordan vi skal jobbe systematisk med arbeidsmiljøet', false);
-- Knytt spørsmål til undertema -> 'Utvikle arbeidsmiljøet'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (40, '067570bb-0aac-7eee-8000-7cea99539721', 2);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0ad8-7505-8000-e54aafd5d97d', '067570bb-0aac-7eee-8000-7cea99539721', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0b09-7c4d-8000-0f3f497b0159', '067570bb-0aac-7eee-8000-7cea99539721', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0b39-7767-8000-2dd7192faca0', '067570bb-0aac-7eee-8000-7cea99539721', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0b67-743a-8000-46f4f2f2facd', '067570bb-0aac-7eee-8000-7cea99539721', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0b92-7956-8000-48cf3b7593ad', '067570bb-0aac-7eee-8000-7cea99539721', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Utvikle arbeidsmiljøet'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570bb-0bc3-7233-8000-58f6d667a679',
        'Vi har fått god forståelse for hvilke faktorer som påvirker arbeidsmiljøet vårt', false);
-- Knytt spørsmål til undertema -> 'Utvikle arbeidsmiljøet'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (40, '067570bb-0bc3-7233-8000-58f6d667a679', 3);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0bf6-745a-8000-d54ec45054c7', '067570bb-0bc3-7233-8000-58f6d667a679', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0c1f-7fe6-8000-e2d5b0080fb6', '067570bb-0bc3-7233-8000-58f6d667a679', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0c52-7f4c-8000-d8b0afdd07d2', '067570bb-0bc3-7233-8000-58f6d667a679', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0c85-7dd8-8000-d4a31eb02c45', '067570bb-0bc3-7233-8000-58f6d667a679', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0cb9-7303-8000-a60dc35597ea', '067570bb-0bc3-7233-8000-58f6d667a679', 'Vet ikke');


-- Nytt undertema -> 'Arbeidsmiljø' : 'Endring og omstilling'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (41, 'Endring og omstilling', 'AKTIV', 2, 24, false);

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Endring og omstilling'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570bb-0ceb-73cc-8000-aa74c3c1da6c',
        'Vi har etablert rutiner for medvirkning og forebygging under endrings- og omstillingsprosesser', false);
-- Knytt spørsmål til undertema -> 'Endring og omstilling'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (41, '067570bb-0ceb-73cc-8000-aa74c3c1da6c', 1);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0d1d-77ec-8000-431dad257f54', '067570bb-0ceb-73cc-8000-aa74c3c1da6c', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0d47-7dc3-8000-e358968baf73', '067570bb-0ceb-73cc-8000-aa74c3c1da6c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0d7a-7bfb-8000-81e752fc2e74', '067570bb-0ceb-73cc-8000-aa74c3c1da6c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0da4-7628-8000-ca692f7ff403', '067570bb-0ceb-73cc-8000-aa74c3c1da6c', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0dd0-7119-8000-7facabef9653', '067570bb-0ceb-73cc-8000-aa74c3c1da6c', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Endring og omstilling'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570bb-0e01-70e8-8000-21b8bb85940f',
        'Vi har nødvendig kompetanse for å forebygge sykefravær under omstillingsprosesser', false);
-- Knytt spørsmål til undertema -> 'Endring og omstilling'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (41, '067570bb-0e01-70e8-8000-21b8bb85940f', 2);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0e2d-704e-8000-c33ec5334e50', '067570bb-0e01-70e8-8000-21b8bb85940f', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0e5e-70f7-8000-9713c055dd35', '067570bb-0e01-70e8-8000-21b8bb85940f', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0e8f-7c1d-8000-694e48ec40d8', '067570bb-0e01-70e8-8000-21b8bb85940f', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0ebf-72f5-8000-e690b6b0221f', '067570bb-0e01-70e8-8000-21b8bb85940f', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0ef2-7cb6-8000-05bf226244c1', '067570bb-0e01-70e8-8000-21b8bb85940f', 'Vet ikke');


-- Nytt undertema -> 'Arbeidsmiljø' : 'Oppfølging av arbeidsmiljøundersøkelser'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (42, 'Oppfølging av arbeidsmiljøundersøkelser', 'AKTIV', 3, 24, false);

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Oppfølging av arbeidsmiljøundersøkelser'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570bb-0f1c-78b8-8000-3deab4d6bda8',
        'Vi har fått tilstrekkelig støtte til å gjennomføre tiltak basert på egen arbeidsmiljøundersøkelse', false);
-- Knytt spørsmål til undertema -> 'Oppfølging av arbeidsmiljøundersøkelser'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (42, '067570bb-0f1c-78b8-8000-3deab4d6bda8', 1);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0f4f-76ad-8000-302a12dff87c', '067570bb-0f1c-78b8-8000-3deab4d6bda8', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0f7f-7f36-8000-e33b5c564a1b', '067570bb-0f1c-78b8-8000-3deab4d6bda8', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0fb2-75a2-8000-1e52856846b6', '067570bb-0f1c-78b8-8000-3deab4d6bda8', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-0fe1-721e-8000-2a44f555ded0', '067570bb-0f1c-78b8-8000-3deab4d6bda8', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-1013-7005-8000-fd5e1e0d6527', '067570bb-0f1c-78b8-8000-3deab4d6bda8', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Oppfølging av arbeidsmiljøundersøkelser'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570bb-103d-7d00-8000-c02ad00ec158',
        'Vi har opparbeidet oss nødvendig kompetanse til å følge opp fremtidige arbeidsmiljøundersøkelser', false);
-- Knytt spørsmål til undertema -> 'Oppfølging av arbeidsmiljøundersøkelser'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (42, '067570bb-103d-7d00-8000-c02ad00ec158', 2);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-106e-7ab7-8000-fd693c90997f', '067570bb-103d-7d00-8000-c02ad00ec158', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-109e-7f95-8000-8608a4b4b925', '067570bb-103d-7d00-8000-c02ad00ec158', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-10ca-7fc4-8000-ab20ff8a9a8b', '067570bb-103d-7d00-8000-c02ad00ec158', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-10f9-751c-8000-8f139971caa6', '067570bb-103d-7d00-8000-c02ad00ec158', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-112c-7386-8000-9cbd38c4bd92', '067570bb-103d-7d00-8000-c02ad00ec158', 'Vet ikke');


-- Nytt undertema -> 'Arbeidsmiljø' : 'Livsfaseorientert personalpolitikk'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (43, 'Livsfaseorientert personalpolitikk', 'AKTIV', 4, 24, false);

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Livsfaseorientert personalpolitikk'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570bb-115a-776d-8000-28d49f310aa4',
        'Vi har en personalpolitikk som ivaretar ansattes behov i ulike deler av livet (f.eks. graviditet, førpensjon)',
        false);
-- Knytt spørsmål til undertema -> 'Livsfaseorientert personalpolitikk'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (43, '067570bb-115a-776d-8000-28d49f310aa4', 1);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-1189-7c7f-8000-2023b6bad493', '067570bb-115a-776d-8000-28d49f310aa4', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-11b8-7f57-8000-ecb6db93dc0c', '067570bb-115a-776d-8000-28d49f310aa4', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-11e9-774a-8000-a973896cd02d', '067570bb-115a-776d-8000-28d49f310aa4', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-1215-7443-8000-2ee641714b42', '067570bb-115a-776d-8000-28d49f310aa4', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-1242-75ae-8000-3e96b2847381', '067570bb-115a-776d-8000-28d49f310aa4', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Livsfaseorientert personalpolitikk'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570bb-1272-7862-8000-390bec38704e',
        'Vi har utarbeidet gode rutiner for hvordan vi tilrettelegger ansattes arbeid i ulike deler av livet', false);
-- Knytt spørsmål til undertema -> 'Livsfaseorientert personalpolitikk'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (43, '067570bb-1272-7862-8000-390bec38704e', 2);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-12a8-78ac-8000-f66c881b5f0a', '067570bb-1272-7862-8000-390bec38704e', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-12d5-7a8d-8000-297f351cc736', '067570bb-1272-7862-8000-390bec38704e', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-1300-7325-8000-25c3a3542313', '067570bb-1272-7862-8000-390bec38704e', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-1333-7cf7-8000-2bfa4ec7a32a', '067570bb-1272-7862-8000-390bec38704e', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-1364-7d2b-8000-41de973bc47c', '067570bb-1272-7862-8000-390bec38704e', 'Vet ikke');


-- Nytt undertema -> 'Arbeidsmiljø' : 'Psykisk helse'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (44, 'Psykisk helse', 'AKTIV', 5, 24, false);

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Psykisk helse'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570bb-138e-768e-8000-7ed6e09186f9',
        'Vi får tilbakemeldinger om at ansatte med psykiske plager blir godt ivaretatt', false);
-- Knytt spørsmål til undertema -> 'Psykisk helse'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (44, '067570bb-138e-768e-8000-7ed6e09186f9', 1);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-13c1-7b10-8000-45b68e99677f', '067570bb-138e-768e-8000-7ed6e09186f9', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-13ea-7f14-8000-5a13262423e7', '067570bb-138e-768e-8000-7ed6e09186f9', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-141e-755c-8000-877cc5785120', '067570bb-138e-768e-8000-7ed6e09186f9', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-1451-7c19-8000-dcf3f584de15', '067570bb-138e-768e-8000-7ed6e09186f9', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-147f-76f4-8000-d39c2dcf40e3', '067570bb-138e-768e-8000-7ed6e09186f9', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Psykisk helse'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570bb-14b2-7dc2-8000-ef13cdf4ec54',
        'Som leder, tillitsvalgt eller verneombud har jeg opparbeidet meg ferdigheter til å møte og støtte ansatte med psykiske plager',
        false);
-- Knytt spørsmål til undertema -> 'Psykisk helse'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (44, '067570bb-14b2-7dc2-8000-ef13cdf4ec54', 2);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-14e6-7612-8000-5a01825a4c56', '067570bb-14b2-7dc2-8000-ef13cdf4ec54', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-1514-7f8b-8000-91b11f873e68', '067570bb-14b2-7dc2-8000-ef13cdf4ec54', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-1548-7754-8000-11a47e6134de', '067570bb-14b2-7dc2-8000-ef13cdf4ec54', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-1571-7d92-8000-ddcaa48a7633', '067570bb-14b2-7dc2-8000-ef13cdf4ec54', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-15a5-7082-8000-c584d90f0eaf', '067570bb-14b2-7dc2-8000-ef13cdf4ec54', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Psykisk helse'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570bb-15d7-70f7-8000-1f5ce2125cb7', 'Vi jobber kontinuerlig for å redusere stigma rundt psykiske plager',
        false);
-- Knytt spørsmål til undertema -> 'Psykisk helse'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (44, '067570bb-15d7-70f7-8000-1f5ce2125cb7', 3);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-160b-7524-8000-78c666dde193', '067570bb-15d7-70f7-8000-1f5ce2125cb7', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-163f-72f5-8000-3d28a658d204', '067570bb-15d7-70f7-8000-1f5ce2125cb7', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-1672-7580-8000-18e3ffe1d0b3', '067570bb-15d7-70f7-8000-1f5ce2125cb7', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-16a3-74eb-8000-48ff58423232', '067570bb-15d7-70f7-8000-1f5ce2125cb7', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-16cf-792a-8000-5faa819e95bd', '067570bb-15d7-70f7-8000-1f5ce2125cb7', 'Vet ikke');


-- Nytt undertema -> 'Arbeidsmiljø' : 'HelseIArbeid'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (45, 'HelseIArbeid', 'AKTIV', 6, 24, false);

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'HelseIArbeid'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570bb-1703-7409-8000-6bb72702d156',
        'Vi har fått økt kompetanse om tilrettelegging for ansatte med muskel-, skjelett- og psykiske plager', false);
-- Knytt spørsmål til undertema -> 'HelseIArbeid'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (45, '067570bb-1703-7409-8000-6bb72702d156', 1);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-1735-7771-8000-4d485505a2a2', '067570bb-1703-7409-8000-6bb72702d156', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-1767-7cf1-8000-14a31b8e2c0b', '067570bb-1703-7409-8000-6bb72702d156', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-1793-7f18-8000-80cbaf75a122', '067570bb-1703-7409-8000-6bb72702d156', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-17c5-70bd-8000-c312a6d73a66', '067570bb-1703-7409-8000-6bb72702d156', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-17f7-7dfa-8000-d715f1cc10d2', '067570bb-1703-7409-8000-6bb72702d156', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'HelseIArbeid'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570bb-1828-7965-8000-3771403aa991',
        'Ansatte ønsker i større grad å jobbe til tross for muskel-, skjelett- og psykiske plager', false);
-- Knytt spørsmål til undertema -> 'HelseIArbeid'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (45, '067570bb-1828-7965-8000-3771403aa991', 2);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-185b-7c77-8000-efef78e07643', '067570bb-1828-7965-8000-3771403aa991', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-1887-7aae-8000-6c28849836ed', '067570bb-1828-7965-8000-3771403aa991', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-18b8-7290-8000-e1e72c2e5194', '067570bb-1828-7965-8000-3771403aa991', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-18eb-7ce8-8000-7ac66b144a99', '067570bb-1828-7965-8000-3771403aa991', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-191e-7f30-8000-1e3410765f87', '067570bb-1828-7965-8000-3771403aa991', 'Vet ikke');


-- Nytt undertema -> 'Arbeidsmiljø' : 'Veien videre'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (46, 'Veien videre', 'AKTIV', 7, 24, true);

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Veien videre'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570bb-1952-7c16-8000-f1f7987b50e2',
        'Vi har opparbeidet oss et godt grunnlag for å jobbe videre med arbeidsmiljøet vårt', false);
-- Knytt spørsmål til undertema -> 'Veien videre'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (46, '067570bb-1952-7c16-8000-f1f7987b50e2', 1);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-1982-7fb5-8000-45be49d6abba', '067570bb-1952-7c16-8000-f1f7987b50e2', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-19b0-7c13-8000-35648239f9c6', '067570bb-1952-7c16-8000-f1f7987b50e2', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-19dd-7ba9-8000-c02fa65d980e', '067570bb-1952-7c16-8000-f1f7987b50e2', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-1a11-76fc-8000-8745d67a766b', '067570bb-1952-7c16-8000-f1f7987b50e2', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-1a3c-7e31-8000-148e573a3af3', '067570bb-1952-7c16-8000-f1f7987b50e2', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Veien videre'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('067570bb-1a70-76e5-8000-09fe2b508350',
        'Vi har utarbeidet konkrete planer for hvordan vi skal videreutvikle arbeidsmiljøet vårt', false);
-- Knytt spørsmål til undertema -> 'Veien videre'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id, rekkefolge)
VALUES (46, '067570bb-1a70-76e5-8000-09fe2b508350', 2);
-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-1aa1-7dfb-8000-8f61acb63390', '067570bb-1a70-76e5-8000-09fe2b508350', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-1ad4-7aa1-8000-0a158dfed97b', '067570bb-1a70-76e5-8000-09fe2b508350', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-1b01-7450-8000-189f025d1710', '067570bb-1a70-76e5-8000-09fe2b508350', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-1b2b-7463-8000-07ebcd4684b9', '067570bb-1a70-76e5-8000-09fe2b508350', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('067570bb-1b55-795f-8000-80a43421b433', '067570bb-1a70-76e5-8000-09fe2b508350', 'Vet ikke');
