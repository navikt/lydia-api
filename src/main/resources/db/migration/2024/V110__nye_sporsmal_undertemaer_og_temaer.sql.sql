-- Gjør tema inaktivt
UPDATE ia_sak_kartlegging_tema
SET status = 'INAKTIV'
WHERE tema_id = 7;

-- Gjør undertema inaktivt
UPDATE ia_sak_kartlegging_undertema
SET status = 'INAKTIV'
WHERE undertema_id = 7;

-- Gjør tema inaktivt
UPDATE ia_sak_kartlegging_tema
SET status = 'INAKTIV'
WHERE tema_id = 8;

-- Gjør undertema inaktivt
UPDATE ia_sak_kartlegging_undertema
SET status = 'INAKTIV'
WHERE undertema_id = 8;

-- Gjør tema inaktivt
UPDATE ia_sak_kartlegging_tema
SET status = 'INAKTIV'
WHERE tema_id = 9;

-- Gjør undertema inaktivt
UPDATE ia_sak_kartlegging_undertema
SET status = 'INAKTIV'
WHERE undertema_id = 9;

-- Nytt tema -> 'Partssamarbeid'
INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, status, rekkefolge, type)
VALUES (16, 'Partssamarbeid', 'AKTIV', 1, 'Evaluering');

-- Nytt undertema -> 'Partssamarbeid' : 'Utvikle partssamarbeidet'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (16, 'Utvikle partssamarbeidet', 'AKTIV', 1, 16, false);

-- Nytt spørsmål for undertema -> 'Partssamarbeid' : 'Utvikle partssamarbeidet'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-bb0f-7eac-8000-9a72fad1089c','Hvordan opplever du at partssamarbeidet har utviklet seg i løpet av samarbeidsperioden?',false);
-- Knytt spørsmål til undertema -> 'Utvikle partssamarbeidet'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (16, '06740ca9-bb0f-7eac-8000-9a72fad1089c', 1);
-- Knytt tema til spørsmål -> 'Partssamarbeid'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (16, '06740ca9-bb0f-7eac-8000-9a72fad1089c');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-bb43-7547-8000-136aa514dbca', '06740ca9-bb0f-7eac-8000-9a72fad1089c', 'Svært godt');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-bb72-74c8-8000-8fa6e3e13d06', '06740ca9-bb0f-7eac-8000-9a72fad1089c', 'Godt');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-bb9b-7b38-8000-531d1d0bc046', '06740ca9-bb0f-7eac-8000-9a72fad1089c', 'Dårlig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-bbcf-7041-8000-d6ca1e15516b', '06740ca9-bb0f-7eac-8000-9a72fad1089c', 'Svært dårlig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-bbf8-75d7-8000-aced076bc15e', '06740ca9-bb0f-7eac-8000-9a72fad1089c', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Partssamarbeid' : 'Utvikle partssamarbeidet'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-bc29-7e0a-8000-0249ba47a313','Som leder, tillitsvalgt eller verneombud har jeg fått en bedre forståelse av min rolle og mine ansvarsområder i partssamarbeidet',false);
-- Knytt spørsmål til undertema -> 'Utvikle partssamarbeidet'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (16, '06740ca9-bc29-7e0a-8000-0249ba47a313', 2);
-- Knytt tema til spørsmål -> 'Partssamarbeid'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (16, '06740ca9-bc29-7e0a-8000-0249ba47a313');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-bc5a-70cf-8000-aec490fed130', '06740ca9-bc29-7e0a-8000-0249ba47a313', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-bc8c-7682-8000-5e8497ffd20e', '06740ca9-bc29-7e0a-8000-0249ba47a313', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-bcbb-7688-8000-757511f5063d', '06740ca9-bc29-7e0a-8000-0249ba47a313', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-bce4-7bec-8000-9f1290fab622', '06740ca9-bc29-7e0a-8000-0249ba47a313', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-bd18-7138-8000-a4430f31266a', '06740ca9-bc29-7e0a-8000-0249ba47a313', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Partssamarbeid' : 'Utvikle partssamarbeidet'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-bd4b-7599-8000-a4942ae48871','Vi har opparbeidet oss nødvendig kompetanse for å forebygge og håndtere sykefraværet vårt',false);
-- Knytt spørsmål til undertema -> 'Utvikle partssamarbeidet'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (16, '06740ca9-bd4b-7599-8000-a4942ae48871', 3);
-- Knytt tema til spørsmål -> 'Partssamarbeid'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (16, '06740ca9-bd4b-7599-8000-a4942ae48871');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-bd7e-79c8-8000-34ce46cc2827', '06740ca9-bd4b-7599-8000-a4942ae48871', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-bdb2-7010-8000-cd61d12f3251', '06740ca9-bd4b-7599-8000-a4942ae48871', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-bddf-7bd6-8000-96ea7227290f', '06740ca9-bd4b-7599-8000-a4942ae48871', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-be13-72c6-8000-3276c6202148', '06740ca9-bd4b-7599-8000-a4942ae48871', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-be46-7972-8000-52bc57072cf7', '06740ca9-bd4b-7599-8000-a4942ae48871', 'Vet ikke');


-- Nytt undertema -> 'Partssamarbeid' : 'Veien videre'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (17, 'Veien videre', 'AKTIV', 2, 16, true);

-- Nytt spørsmål for undertema -> 'Partssamarbeid' : 'Veien videre'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-be78-7a5c-8000-921345c7b064','Vi har laget konkrete planer for hvordan vi i partssamarbeidet skal jobbe fremover',false);
-- Knytt spørsmål til undertema -> 'Veien videre'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (17, '06740ca9-be78-7a5c-8000-921345c7b064', 1);
-- Knytt tema til spørsmål -> 'Partssamarbeid'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (16, '06740ca9-be78-7a5c-8000-921345c7b064');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-beac-717e-8000-45a534340cc6', '06740ca9-be78-7a5c-8000-921345c7b064', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-bedf-7212-8000-117c56d4f1c4', '06740ca9-be78-7a5c-8000-921345c7b064', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-bf11-7ea7-8000-f722836c6b0a', '06740ca9-be78-7a5c-8000-921345c7b064', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-bf42-757c-8000-827a0a2751ea', '06740ca9-be78-7a5c-8000-921345c7b064', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-bf70-7b06-8000-97084ad8bca4', '06740ca9-be78-7a5c-8000-921345c7b064', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Partssamarbeid' : 'Veien videre'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-bf9f-70b2-8000-4de38f2267b3','Jeg opplever at vi er motiverte for å samarbeide videre om sykefravær og arbeidsmiljø',false);
-- Knytt spørsmål til undertema -> 'Veien videre'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (17, '06740ca9-bf9f-70b2-8000-4de38f2267b3', 2);
-- Knytt tema til spørsmål -> 'Partssamarbeid'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (16, '06740ca9-bf9f-70b2-8000-4de38f2267b3');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-bfcd-750e-8000-04a970d50730', '06740ca9-bf9f-70b2-8000-4de38f2267b3', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c000-7e8c-8000-59f751c79cd8', '06740ca9-bf9f-70b2-8000-4de38f2267b3', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c033-742e-8000-b91ee8511cbb', '06740ca9-bf9f-70b2-8000-4de38f2267b3', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c066-7aec-8000-b2aa780a1bbe', '06740ca9-bf9f-70b2-8000-4de38f2267b3', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c09a-73a0-8000-6606457ee29d', '06740ca9-bf9f-70b2-8000-4de38f2267b3', 'Vet ikke');



-- Nytt tema -> 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, status, rekkefolge, type)
VALUES (17, 'Sykefraværsarbeid', 'AKTIV', 2, 'Evaluering');

-- Nytt undertema -> 'Sykefraværsarbeid' : 'Sykefraværsrutiner'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (18, 'Sykefraværsrutiner', 'AKTIV', 1, 17, false);

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Sykefraværsrutiner'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-c0cd-7a09-8000-09a994557c6c','Vi jobber nå mer systematisk for å forebygge sykefraværet vårt',false);
-- Knytt spørsmål til undertema -> 'Sykefraværsrutiner'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (18, '06740ca9-c0cd-7a09-8000-09a994557c6c', 1);
-- Knytt tema til spørsmål -> 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '06740ca9-c0cd-7a09-8000-09a994557c6c');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c100-7fa9-8000-07250761e08c', '06740ca9-c0cd-7a09-8000-09a994557c6c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c134-7491-8000-15acfa130b77', '06740ca9-c0cd-7a09-8000-09a994557c6c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c167-79aa-8000-8fba1dd615da', '06740ca9-c0cd-7a09-8000-09a994557c6c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c197-7e88-8000-9c163532b7f3', '06740ca9-c0cd-7a09-8000-09a994557c6c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c1cb-7545-8000-fe6711e64ac5', '06740ca9-c0cd-7a09-8000-09a994557c6c', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Sykefraværsrutiner'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-c1fe-7c24-8000-4dc4a03fbb67','Vi har godt etablerte og lett tilgjengelige sykefraværsrutiner',false);
-- Knytt spørsmål til undertema -> 'Sykefraværsrutiner'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (18, '06740ca9-c1fe-7c24-8000-4dc4a03fbb67', 2);
-- Knytt tema til spørsmål -> 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '06740ca9-c1fe-7c24-8000-4dc4a03fbb67');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c232-71a2-8000-90099667178a', '06740ca9-c1fe-7c24-8000-4dc4a03fbb67', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c265-7753-8000-9ce7b0013aa6', '06740ca9-c1fe-7c24-8000-4dc4a03fbb67', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c298-7d36-8000-14e540e4894c', '06740ca9-c1fe-7c24-8000-4dc4a03fbb67', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c2c6-7e6d-8000-e8ffffcc3cbd', '06740ca9-c1fe-7c24-8000-4dc4a03fbb67', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c2f5-7686-8000-88b46125897b', '06740ca9-c1fe-7c24-8000-4dc4a03fbb67', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Sykefraværsrutiner'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-c323-79f7-8000-33eb792daf3c','Ansatte kjenner til egne plikter og rettigheter når de er sykmeldt eller står i fare for å bli det',false);
-- Knytt spørsmål til undertema -> 'Sykefraværsrutiner'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (18, '06740ca9-c323-79f7-8000-33eb792daf3c', 3);
-- Knytt tema til spørsmål -> 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '06740ca9-c323-79f7-8000-33eb792daf3c');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c356-7ffc-8000-09304a72998c', '06740ca9-c323-79f7-8000-33eb792daf3c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c38a-74e3-8000-e91f6fb2caef', '06740ca9-c323-79f7-8000-33eb792daf3c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c3bd-79a9-8000-f0dbe620f4e5', '06740ca9-c323-79f7-8000-33eb792daf3c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c3f0-72d5-8000-288b08acb986', '06740ca9-c323-79f7-8000-33eb792daf3c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c423-7832-8000-a949943ec8ce', '06740ca9-c323-79f7-8000-33eb792daf3c', 'Vet ikke');


-- Nytt undertema -> 'Sykefraværsarbeid' : 'Oppfølgingssamtaler'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (19, 'Oppfølgingssamtaler', 'AKTIV', 2, 17, false);

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Oppfølgingssamtaler'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-c456-7e04-8000-774c5d4601a1','Jeg opplever at ledere er trygge under oppfølgingsamtaler med ansatte som er sykmeldt eller står i fare for å bli det',false);
-- Knytt spørsmål til undertema -> 'Oppfølgingssamtaler'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (19, '06740ca9-c456-7e04-8000-774c5d4601a1', 1);
-- Knytt tema til spørsmål -> 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '06740ca9-c456-7e04-8000-774c5d4601a1');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c48a-74c1-8000-ded38fe892c1', '06740ca9-c456-7e04-8000-774c5d4601a1', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c4bc-7ff6-8000-a3677a4a1ba5', '06740ca9-c456-7e04-8000-774c5d4601a1', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c4ed-7a87-8000-2a9b2a66bf36', '06740ca9-c456-7e04-8000-774c5d4601a1', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c519-749e-8000-67bf0f6a4556', '06740ca9-c456-7e04-8000-774c5d4601a1', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c545-7e80-8000-65d04265b04e', '06740ca9-c456-7e04-8000-774c5d4601a1', 'Vet ikke');


-- Nytt undertema -> 'Sykefraværsarbeid' : 'Tilretteleggings- og medvirkningsplikt'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (20, 'Tilretteleggings- og medvirkningsplikt', 'AKTIV', 3, 17, false);

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Tilretteleggings- og medvirkningsplikt'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-c572-7474-8000-430343eb85a4','Vi har utarbeidet og tilgjengeliggjort en oversikt over våre tilretteleggingsmuligheter',false);
-- Knytt spørsmål til undertema -> 'Tilretteleggings- og medvirkningsplikt'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (20, '06740ca9-c572-7474-8000-430343eb85a4', 1);
-- Knytt tema til spørsmål -> 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '06740ca9-c572-7474-8000-430343eb85a4');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c5a2-71d9-8000-b21ec98d9a99', '06740ca9-c572-7474-8000-430343eb85a4', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c5ce-7768-8000-3fcb8da26da9', '06740ca9-c572-7474-8000-430343eb85a4', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c5fb-70c4-8000-167cba56824b', '06740ca9-c572-7474-8000-430343eb85a4', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c62e-78d1-8000-20623d030f7a', '06740ca9-c572-7474-8000-430343eb85a4', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c65f-74e4-8000-606238f7bcc4', '06740ca9-c572-7474-8000-430343eb85a4', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Tilretteleggings- og medvirkningsplikt'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-c68b-7bb1-8000-dc36ca40e48b','Vi har etablerte rutiner og god kultur for tilrettelegging for ansatte',false);
-- Knytt spørsmål til undertema -> 'Tilretteleggings- og medvirkningsplikt'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (20, '06740ca9-c68b-7bb1-8000-dc36ca40e48b', 2);
-- Knytt tema til spørsmål -> 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '06740ca9-c68b-7bb1-8000-dc36ca40e48b');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c6bc-7675-8000-6dd8d8dcb9a0', '06740ca9-c68b-7bb1-8000-dc36ca40e48b', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c6e9-78fe-8000-0def0d333741', '06740ca9-c68b-7bb1-8000-dc36ca40e48b', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c718-7915-8000-173188fa40d0', '06740ca9-c68b-7bb1-8000-dc36ca40e48b', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c745-7ec3-8000-fbd70ce171d3', '06740ca9-c68b-7bb1-8000-dc36ca40e48b', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c779-76e1-8000-60219c7e6ffe', '06740ca9-c68b-7bb1-8000-dc36ca40e48b', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Tilretteleggings- og medvirkningsplikt'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-c7ab-7f98-8000-40ad8144e7a7','Ansatte medvirker under tilrettelegging av arbeidsoppgaver',false);
-- Knytt spørsmål til undertema -> 'Tilretteleggings- og medvirkningsplikt'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (20, '06740ca9-c7ab-7f98-8000-40ad8144e7a7', 3);
-- Knytt tema til spørsmål -> 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '06740ca9-c7ab-7f98-8000-40ad8144e7a7');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c7df-78e3-8000-4cbc9c5a926b', '06740ca9-c7ab-7f98-8000-40ad8144e7a7', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c80f-7ca4-8000-07c201d08d93', '06740ca9-c7ab-7f98-8000-40ad8144e7a7', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c843-7537-8000-c2c83bb485ea', '06740ca9-c7ab-7f98-8000-40ad8144e7a7', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c871-7b8a-8000-3ee49782f461', '06740ca9-c7ab-7f98-8000-40ad8144e7a7', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c8a5-73da-8000-75d04f878ab7', '06740ca9-c7ab-7f98-8000-40ad8144e7a7', 'Vet ikke');


-- Nytt undertema -> 'Sykefraværsarbeid' : 'Sykefravær - enkeltsaker'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (21, 'Sykefravær - enkeltsaker', 'AKTIV', 4, 17, false);

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Sykefravær - enkeltsaker'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-c8d5-7e6b-8000-6132b2618fab','Vi har nødvendig kompetanse for å håndtere vanskelige sykefraværssaker',false);
-- Knytt spørsmål til undertema -> 'Sykefravær - enkeltsaker'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (21, '06740ca9-c8d5-7e6b-8000-6132b2618fab', 1);
-- Knytt tema til spørsmål -> 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '06740ca9-c8d5-7e6b-8000-6132b2618fab');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c901-7605-8000-248fd930ed55', '06740ca9-c8d5-7e6b-8000-6132b2618fab', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c932-7bfd-8000-931263f842b2', '06740ca9-c8d5-7e6b-8000-6132b2618fab', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c966-757b-8000-2dc9e51cec54', '06740ca9-c8d5-7e6b-8000-6132b2618fab', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c994-73bf-8000-dda575ec2d95', '06740ca9-c8d5-7e6b-8000-6132b2618fab', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-c9bd-7e61-8000-0c1cf4993552', '06740ca9-c8d5-7e6b-8000-6132b2618fab', 'Vet ikke');


-- Nytt undertema -> 'Sykefraværsarbeid' : 'Veien videre'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (22, 'Veien videre', 'AKTIV', 5, 17, true);

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Veien videre'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-c9f0-7292-8000-5e746f0d6da2','Vi vet hvor vi finner gode verktøy i arbeidet med å redusere sykefraværet vårt',false);
-- Knytt spørsmål til undertema -> 'Veien videre'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (22, '06740ca9-c9f0-7292-8000-5e746f0d6da2', 1);
-- Knytt tema til spørsmål -> 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '06740ca9-c9f0-7292-8000-5e746f0d6da2');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-ca23-7810-8000-dae18c83af34', '06740ca9-c9f0-7292-8000-5e746f0d6da2', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-ca56-7c93-8000-7b6c729fc689', '06740ca9-c9f0-7292-8000-5e746f0d6da2', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-ca87-7c41-8000-8d2faae7f935', '06740ca9-c9f0-7292-8000-5e746f0d6da2', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-cabb-7070-8000-3c595609e4dc', '06740ca9-c9f0-7292-8000-5e746f0d6da2', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-caf1-7715-8000-698f2c508da4', '06740ca9-c9f0-7292-8000-5e746f0d6da2', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Veien videre'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-cb24-7b76-8000-3138707880f0','Jeg tror videre forebyggende sykefraværsarbeid vil bidra til å redusere sykefraværet hos oss',false);
-- Knytt spørsmål til undertema -> 'Veien videre'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (22, '06740ca9-cb24-7b76-8000-3138707880f0', 2);
-- Knytt tema til spørsmål -> 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '06740ca9-cb24-7b76-8000-3138707880f0');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-cb57-7f84-8000-0dc329b26b36', '06740ca9-cb24-7b76-8000-3138707880f0', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-cb8b-7380-8000-ec5904581760', '06740ca9-cb24-7b76-8000-3138707880f0', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-cbbe-777d-8000-47322d02c58d', '06740ca9-cb24-7b76-8000-3138707880f0', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-cbf1-7b58-8000-57ef657ceb7e', '06740ca9-cb24-7b76-8000-3138707880f0', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-cc24-7f87-8000-3760311acceb', '06740ca9-cb24-7b76-8000-3138707880f0', 'Vet ikke');



-- Nytt tema -> 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, status, rekkefolge, type)
VALUES (18, 'Arbeidsmiljø', 'AKTIV', 3, 'Evaluering');

-- Nytt undertema -> 'Arbeidsmiljø' : 'Utvikle arbeidsmiljøet'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (23, 'Utvikle arbeidsmiljøet', 'AKTIV', 1, 18, false);

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Utvikle arbeidsmiljøet'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-cc58-74a0-8000-a6c45356b238','Vi har nå nødvendig kompetanse til å gjøre tiltak og forbedre arbeidsmiljøet vårt',false);
-- Knytt spørsmål til undertema -> 'Utvikle arbeidsmiljøet'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (23, '06740ca9-cc58-74a0-8000-a6c45356b238', 1);
-- Knytt tema til spørsmål -> 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '06740ca9-cc58-74a0-8000-a6c45356b238');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-cc8b-7977-8000-4b1aadedaa94', '06740ca9-cc58-74a0-8000-a6c45356b238', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-ccbe-7e3d-8000-60474441f505', '06740ca9-cc58-74a0-8000-a6c45356b238', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-ccf2-72af-8000-a54367f56e34', '06740ca9-cc58-74a0-8000-a6c45356b238', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-cd25-7753-8000-5514c19f8620', '06740ca9-cc58-74a0-8000-a6c45356b238', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-cd58-7c6d-8000-890da0650446', '06740ca9-cc58-74a0-8000-a6c45356b238', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Utvikle arbeidsmiljøet'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-cd8c-7261-8000-49eec44bc916','Vi har utarbeidet konkrete planer for hvordan vi skal jobbe systematisk med arbeidsmiljøet',false);
-- Knytt spørsmål til undertema -> 'Utvikle arbeidsmiljøet'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (23, '06740ca9-cd8c-7261-8000-49eec44bc916', 2);
-- Knytt tema til spørsmål -> 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '06740ca9-cd8c-7261-8000-49eec44bc916');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-cdc0-7863-8000-da18c12c800c', '06740ca9-cd8c-7261-8000-49eec44bc916', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-cdf0-72c4-8000-b9d8c9e5096d', '06740ca9-cd8c-7261-8000-49eec44bc916', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-ce23-7a19-8000-09022213de50', '06740ca9-cd8c-7261-8000-49eec44bc916', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-ce57-715c-8000-f16984dbeaff', '06740ca9-cd8c-7261-8000-49eec44bc916', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-ce8a-76da-8000-836c03375b6f', '06740ca9-cd8c-7261-8000-49eec44bc916', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Utvikle arbeidsmiljøet'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-cebd-7ba0-8000-3ea938332c4c','Vi har fått god forståelse for hvilke faktorer som påvirker arbeidsmiljøet vårt',false);
-- Knytt spørsmål til undertema -> 'Utvikle arbeidsmiljøet'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (23, '06740ca9-cebd-7ba0-8000-3ea938332c4c', 3);
-- Knytt tema til spørsmål -> 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '06740ca9-cebd-7ba0-8000-3ea938332c4c');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-cef1-7066-8000-d9189aac7ff6', '06740ca9-cebd-7ba0-8000-3ea938332c4c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-cf24-756f-8000-c537ba6e3e2a', '06740ca9-cebd-7ba0-8000-3ea938332c4c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-cf57-7a24-8000-48fc5b6ddbea', '06740ca9-cebd-7ba0-8000-3ea938332c4c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-cf8a-7efb-8000-22ac4a93d075', '06740ca9-cebd-7ba0-8000-3ea938332c4c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-cfbe-7d30-8000-d79af7d07bec', '06740ca9-cebd-7ba0-8000-3ea938332c4c', 'Vet ikke');


-- Nytt undertema -> 'Arbeidsmiljø' : 'Endring og omstilling'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (24, 'Endring og omstilling', 'AKTIV', 2, 18, false);

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Endring og omstilling'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-cfe9-78fe-8000-ff2c61814c0b','Vi har etablert rutiner for medvirkning og forebygging under endrings- og omstillingsprosesser',false);
-- Knytt spørsmål til undertema -> 'Endring og omstilling'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (24, '06740ca9-cfe9-78fe-8000-ff2c61814c0b', 1);
-- Knytt tema til spørsmål -> 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '06740ca9-cfe9-78fe-8000-ff2c61814c0b');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d01d-74e8-8000-5d90048edfc9', '06740ca9-cfe9-78fe-8000-ff2c61814c0b', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d04a-7d68-8000-d7098f99f695', '06740ca9-cfe9-78fe-8000-ff2c61814c0b', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d07e-76a3-8000-449617ddaaed', '06740ca9-cfe9-78fe-8000-ff2c61814c0b', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d0ab-766b-8000-a8eb805d8e49', '06740ca9-cfe9-78fe-8000-ff2c61814c0b', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d0de-7f30-8000-1e43284dc643', '06740ca9-cfe9-78fe-8000-ff2c61814c0b', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Endring og omstilling'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-d10b-7a51-8000-b0dd9adf316b','Vi har nødvendig kompetanse for å forebygge sykefravær under omstillingsprosesser',false);
-- Knytt spørsmål til undertema -> 'Endring og omstilling'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (24, '06740ca9-d10b-7a51-8000-b0dd9adf316b', 2);
-- Knytt tema til spørsmål -> 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '06740ca9-d10b-7a51-8000-b0dd9adf316b');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d13f-7088-8000-d174ba23192d', '06740ca9-d10b-7a51-8000-b0dd9adf316b', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d16e-7104-8000-95fecc6693b5', '06740ca9-d10b-7a51-8000-b0dd9adf316b', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d1a0-7b3d-8000-a10caebc8f1a', '06740ca9-d10b-7a51-8000-b0dd9adf316b', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d1cd-7972-8000-49d00750307c', '06740ca9-d10b-7a51-8000-b0dd9adf316b', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d1fd-7188-8000-66f2a90e2f68', '06740ca9-d10b-7a51-8000-b0dd9adf316b', 'Vet ikke');


-- Nytt undertema -> 'Arbeidsmiljø' : 'Oppfølging av arbeidsmiljøundersøkelser'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (25, 'Oppfølging av arbeidsmiljøundersøkelser', 'AKTIV', 3, 18, false);

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Oppfølging av arbeidsmiljøundersøkelser'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-d230-7b8c-8000-0c0905022b29','Vi har fått tilstrekkelig støtte til å gjennomføre tiltak basert på egen arbeidsmiljøundersøkelse',false);
-- Knytt spørsmål til undertema -> 'Oppfølging av arbeidsmiljøundersøkelser'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (25, '06740ca9-d230-7b8c-8000-0c0905022b29', 1);
-- Knytt tema til spørsmål -> 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '06740ca9-d230-7b8c-8000-0c0905022b29');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d264-7345-8000-c648d9cd8e16', '06740ca9-d230-7b8c-8000-0c0905022b29', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d295-76d1-8000-8fc3c84e74ed', '06740ca9-d230-7b8c-8000-0c0905022b29', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d2c8-7e8a-8000-1f2ad13744aa', '06740ca9-d230-7b8c-8000-0c0905022b29', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d2f6-7d33-8000-5c4372e7adc8', '06740ca9-d230-7b8c-8000-0c0905022b29', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d327-733e-8000-4f6f6b9b8a2c', '06740ca9-d230-7b8c-8000-0c0905022b29', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Oppfølging av arbeidsmiljøundersøkelser'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-d35a-7964-8000-9976b6195748','Vi har opparbeidet oss nødvendig kompetanse til å følge opp fremtidige arbeidsmiljøundersøkelser',false);
-- Knytt spørsmål til undertema -> 'Oppfølging av arbeidsmiljøundersøkelser'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (25, '06740ca9-d35a-7964-8000-9976b6195748', 2);
-- Knytt tema til spørsmål -> 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '06740ca9-d35a-7964-8000-9976b6195748');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d38e-70fc-8000-ca454ae4765a', '06740ca9-d35a-7964-8000-9976b6195748', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d3c1-797e-8000-ccd798431c1b', '06740ca9-d35a-7964-8000-9976b6195748', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d3f5-7211-8000-96084927029a', '06740ca9-d35a-7964-8000-9976b6195748', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d428-7aa4-8000-6bcc7ebcc982', '06740ca9-d35a-7964-8000-9976b6195748', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d45c-73ac-8000-e79e1f2a984c', '06740ca9-d35a-7964-8000-9976b6195748', 'Vet ikke');


-- Nytt undertema -> 'Arbeidsmiljø' : 'Livsfaseorientert personalpolitikk'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (26, 'Livsfaseorientert personalpolitikk', 'AKTIV', 4, 18, false);

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Livsfaseorientert personalpolitikk'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-d48a-7212-8000-a37822095484','Vi har en personalpolitikk som ivaretar ansattes behov i ulike deler av livet (f.eks. graviditet, førpensjon)',false);
-- Knytt spørsmål til undertema -> 'Livsfaseorientert personalpolitikk'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (26, '06740ca9-d48a-7212-8000-a37822095484', 1);
-- Knytt tema til spørsmål -> 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '06740ca9-d48a-7212-8000-a37822095484');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d4bb-741b-8000-27c7c7766abd', '06740ca9-d48a-7212-8000-a37822095484', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d4e6-7fc5-8000-39a584475081', '06740ca9-d48a-7212-8000-a37822095484', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d51a-7a60-8000-c2ab148ab47a', '06740ca9-d48a-7212-8000-a37822095484', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d544-7ed6-8000-d5bbb32b6ade', '06740ca9-d48a-7212-8000-a37822095484', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d570-73e2-8000-4a4701de37c4', '06740ca9-d48a-7212-8000-a37822095484', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Livsfaseorientert personalpolitikk'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-d5a1-7a3f-8000-c2e0036515d1','Vi har utarbeidet gode rutiner for hvordan vi tilrettelegger ansattes arbeid i ulike deler av livet',false);
-- Knytt spørsmål til undertema -> 'Livsfaseorientert personalpolitikk'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (26, '06740ca9-d5a1-7a3f-8000-c2e0036515d1', 2);
-- Knytt tema til spørsmål -> 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '06740ca9-d5a1-7a3f-8000-c2e0036515d1');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d5d1-77b5-8000-ed846f1f60c2', '06740ca9-d5a1-7a3f-8000-c2e0036515d1', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d604-7f7e-8000-59e12e4fbc83', '06740ca9-d5a1-7a3f-8000-c2e0036515d1', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d638-76b1-8000-476c2dda961e', '06740ca9-d5a1-7a3f-8000-c2e0036515d1', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d66b-7d3c-8000-efaf707d99d2', '06740ca9-d5a1-7a3f-8000-c2e0036515d1', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d69f-742b-8000-a8cb5b71fe4f', '06740ca9-d5a1-7a3f-8000-c2e0036515d1', 'Vet ikke');


-- Nytt undertema -> 'Arbeidsmiljø' : 'Psykisk helse'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (27, 'Psykisk helse', 'AKTIV', 5, 18, false);

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Psykisk helse'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-d6d2-7a51-8000-e3c6851e30af','Vi får tilbakemeldinger om at ansatte med psykiske plager blir godt ivaretatt',false);
-- Knytt spørsmål til undertema -> 'Psykisk helse'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (27, '06740ca9-d6d2-7a51-8000-e3c6851e30af', 1);
-- Knytt tema til spørsmål -> 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '06740ca9-d6d2-7a51-8000-e3c6851e30af');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d706-7562-8000-e96a378dfd84', '06740ca9-d6d2-7a51-8000-e3c6851e30af', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d73a-72ad-8000-5319ca8d49fc', '06740ca9-d6d2-7a51-8000-e3c6851e30af', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d767-71ef-8000-e6b201ff9601', '06740ca9-d6d2-7a51-8000-e3c6851e30af', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d796-7feb-8000-074d728bf2be', '06740ca9-d6d2-7a51-8000-e3c6851e30af', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d7ca-7793-8000-e94a072377a4', '06740ca9-d6d2-7a51-8000-e3c6851e30af', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Psykisk helse'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-d7fd-7640-8000-abbb8ad235ea','Som leder, tillitsvalgt eller verneombud har jeg opparbeidet meg ferdigheter til å møte og støtte ansatte med psykiske plager',false);
-- Knytt spørsmål til undertema -> 'Psykisk helse'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (27, '06740ca9-d7fd-7640-8000-abbb8ad235ea', 2);
-- Knytt tema til spørsmål -> 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '06740ca9-d7fd-7640-8000-abbb8ad235ea');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d828-73d3-8000-08ce6b5541ff', '06740ca9-d7fd-7640-8000-abbb8ad235ea', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d85a-7da7-8000-5fc63024d0ed', '06740ca9-d7fd-7640-8000-abbb8ad235ea', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d88e-763a-8000-a209f016511b', '06740ca9-d7fd-7640-8000-abbb8ad235ea', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d8bc-7f5f-8000-c2b4914b81f5', '06740ca9-d7fd-7640-8000-abbb8ad235ea', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d8f0-7878-8000-08d178489450', '06740ca9-d7fd-7640-8000-abbb8ad235ea', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Psykisk helse'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-d91d-7840-8000-667bac4b62bc','Vi jobber kontinuerlig for å redusere stigma rundt psykiske plager',false);
-- Knytt spørsmål til undertema -> 'Psykisk helse'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (27, '06740ca9-d91d-7840-8000-667bac4b62bc', 3);
-- Knytt tema til spørsmål -> 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '06740ca9-d91d-7840-8000-667bac4b62bc');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d951-7116-8000-96a54423214e', '06740ca9-d91d-7840-8000-667bac4b62bc', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d984-7a40-8000-320e38f38970', '06740ca9-d91d-7840-8000-667bac4b62bc', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d9ae-799a-8000-c42b78085d61', '06740ca9-d91d-7840-8000-667bac4b62bc', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-d9df-7b71-8000-bf9cfb9841c1', '06740ca9-d91d-7840-8000-667bac4b62bc', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-da13-7469-8000-69cab669c5e5', '06740ca9-d91d-7840-8000-667bac4b62bc', 'Vet ikke');


-- Nytt undertema -> 'Arbeidsmiljø' : 'HelseIArbeid'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (28, 'HelseIArbeid', 'AKTIV', 6, 18, false);

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'HelseIArbeid'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-da46-7c11-8000-e46079df4ce9','Vi har fått økt kompetanse om tilrettelegging for ansatte med muskel-, skjelett- og psykiske plager',false);
-- Knytt spørsmål til undertema -> 'HelseIArbeid'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (28, '06740ca9-da46-7c11-8000-e46079df4ce9', 1);
-- Knytt tema til spørsmål -> 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '06740ca9-da46-7c11-8000-e46079df4ce9');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-da7a-7461-8000-c9a5c5e06d77', '06740ca9-da46-7c11-8000-e46079df4ce9', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-daad-7adb-8000-4386e3b40b7a', '06740ca9-da46-7c11-8000-e46079df4ce9', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-dae1-70e0-8000-5fc3f64d2b50', '06740ca9-da46-7c11-8000-e46079df4ce9', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-db14-76f5-8000-89abe096f658', '06740ca9-da46-7c11-8000-e46079df4ce9', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-db45-7836-8000-e01901bef435', '06740ca9-da46-7c11-8000-e46079df4ce9', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'HelseIArbeid'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-db78-7df7-8000-265dfad26d7e','Ansatte ønsker i større grad å jobbe til tross for muskel-, skjelett- og psykiske plager',false);
-- Knytt spørsmål til undertema -> 'HelseIArbeid'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (28, '06740ca9-db78-7df7-8000-265dfad26d7e', 2);
-- Knytt tema til spørsmål -> 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '06740ca9-db78-7df7-8000-265dfad26d7e');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-dbac-73b9-8000-7ba10e1ad85f', '06740ca9-db78-7df7-8000-265dfad26d7e', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-dbdf-7916-8000-8df6878febf7', '06740ca9-db78-7df7-8000-265dfad26d7e', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-dc12-770b-8000-875db7c04f09', '06740ca9-db78-7df7-8000-265dfad26d7e', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-dc45-7b8d-8000-9ce16cc80d09', '06740ca9-db78-7df7-8000-265dfad26d7e', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-dc78-7b47-8000-95eb48875c8d', '06740ca9-db78-7df7-8000-265dfad26d7e', 'Vet ikke');


-- Nytt undertema -> 'Arbeidsmiljø' : 'Veien videre'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (29, 'Veien videre', 'AKTIV', 7, 18, true);

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Veien videre'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-dcac-712a-8000-b5cafa93edd1','Vi har opparbeidet oss et godt grunnlag for å jobbe videre med arbeidsmiljøet vårt',false);
-- Knytt spørsmål til undertema -> 'Veien videre'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (29, '06740ca9-dcac-712a-8000-b5cafa93edd1', 1);
-- Knytt tema til spørsmål -> 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '06740ca9-dcac-712a-8000-b5cafa93edd1');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-dcd5-738a-8000-ffdc3f31efad', '06740ca9-dcac-712a-8000-b5cafa93edd1', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-dd06-73ae-8000-e08912f7b301', '06740ca9-dcac-712a-8000-b5cafa93edd1', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-dd39-7873-8000-1a09760fcb3c', '06740ca9-dcac-712a-8000-b5cafa93edd1', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-dd6d-7213-8000-d7f399e4d1a0', '06740ca9-dcac-712a-8000-b5cafa93edd1', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-dda0-7bb2-8000-77126865f639', '06740ca9-dcac-712a-8000-b5cafa93edd1', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Arbeidsmiljø' : 'Veien videre'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('06740ca9-ddce-72d1-8000-d92919c20caf','Vi har utarbeidet konkrete planer for hvordan vi skal videreutvikle arbeidsmiljøet vårt',false);
-- Knytt spørsmål til undertema -> 'Veien videre'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (29, '06740ca9-ddce-72d1-8000-d92919c20caf', 2);
-- Knytt tema til spørsmål -> 'Arbeidsmiljø'
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '06740ca9-ddce-72d1-8000-d92919c20caf');

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-de01-7aac-8000-03ffa6d0de62', '06740ca9-ddce-72d1-8000-d92919c20caf', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-de34-77b6-8000-3a02256a14dc', '06740ca9-ddce-72d1-8000-d92919c20caf', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-de63-7cfb-8000-586b0484f4f5', '06740ca9-ddce-72d1-8000-d92919c20caf', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-de94-72b3-8000-9a12ee5be60b', '06740ca9-ddce-72d1-8000-d92919c20caf', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('06740ca9-dec4-748c-8000-b53f58fafe4f', '06740ca9-ddce-72d1-8000-d92919c20caf', 'Vet ikke');



