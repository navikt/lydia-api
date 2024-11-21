UPDATE ia_sak_kartlegging_tema
SET status = 'INAKTIV'
WHERE tema_id = 12;

-- Nytt tema

INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, status, rekkefolge, type)
VALUES (16, 'Partssamarbeid', 'AKTIV', 1, 'Evaluering');

INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (16, 'Utvikle partssamarbeidet', 'AKTIV', 1, 16, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Hvordan opplever du at partssamarbeidet har utviklet seg i løpet av samarbeidsperioden?',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d94-76f5-8000-c563d8c71b9b', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Svært godt');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d99-7ab6-8000-f9645b40539d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Godt');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d9e-7de1-8000-aca77d0005cb', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Dårlig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8da4-710b-8000-ccc7437222cf', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Svært dårlig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8da9-7414-8000-8a9b91582191', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (16, '0673f406-8d6e-7d99-8000-c6bc53bd0910');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Som leder, tillitsvalgt eller verneombud har jeg fått en bedre forståelse av min rolle og mine ansvarsområder i partssamarbeidet',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (16, '0673f406-8d6e-7d99-8000-c6bc53bd0910');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Vi har opparbeidet oss nødvendig kompetanse for å forebygge og håndtere sykefraværet vårt',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (16, '0673f406-8d6e-7d99-8000-c6bc53bd0910');INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (17, 'Veien videre', 'AKTIV', 2, 16, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Vi har laget konkrete planer for hvordan vi i partssamarbeidet skal jobbe fremover',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (16, '0673f406-8d6e-7d99-8000-c6bc53bd0910');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Jeg opplever at vi er motiverte for å samarbeide videre om sykefravær og arbeidsmiljø',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (16, '0673f406-8d6e-7d99-8000-c6bc53bd0910');

-- Nytt tema

INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, status, rekkefolge, type)
VALUES (17, 'Sykefraværsarbeid', 'AKTIV', 2, 'Evaluering');

INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (18, 'Sykefraværsrutiner', 'AKTIV', 3, 17, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Vi jobber nå mer systematisk for å forebygge sykefraværet vårt',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '0673f406-8d6e-7d99-8000-c6bc53bd0910');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Vi har godt etablerte og lett tilgjengelige sykefraværsrutiner',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '0673f406-8d6e-7d99-8000-c6bc53bd0910');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Ansatte kjenner til egne plikter og rettigheter når de er sykmeldt eller står i fare for å bli det',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '0673f406-8d6e-7d99-8000-c6bc53bd0910');INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (19, 'Oppfølgingssamtaler', 'AKTIV', 4, 17, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Jeg opplever at ledere er trygge under oppfølgingsamtaler med ansatte som er sykmeldt eller står i fare for å bli det',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '0673f406-8d6e-7d99-8000-c6bc53bd0910');INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (20, 'Tilretteleggings- og medvirkningsplikt', 'AKTIV', 5, 17, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Vi har utarbeidet og tilgjengeliggjort en oversikt over våre tilretteleggingsmuligheter',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '0673f406-8d6e-7d99-8000-c6bc53bd0910');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Vi har etablerte rutiner og god kultur for tilrettelegging for ansatte',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '0673f406-8d6e-7d99-8000-c6bc53bd0910');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Ansatte medvirker under tilrettelegging av arbeidsoppgaver',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '0673f406-8d6e-7d99-8000-c6bc53bd0910');INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (21, 'Sykefravær - enkeltsaker', 'AKTIV', 6, 17, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Vi har nødvendig kompetanse for å håndtere vanskelige sykefraværssaker',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '0673f406-8d6e-7d99-8000-c6bc53bd0910');INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (22, 'Veien videre', 'AKTIV', 7, 17, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Vi vet hvor vi finner gode verktøy i arbeidet med å redusere sykefraværet vårt',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '0673f406-8d6e-7d99-8000-c6bc53bd0910');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Jeg tror videre forebyggende sykefraværsarbeid vil bidra til å redusere sykefraværet hos oss',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '0673f406-8d6e-7d99-8000-c6bc53bd0910');

-- Nytt tema

INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, status, rekkefolge, type)
VALUES (18, 'Arbeidsmiljø', 'AKTIV', 3, 'Evaluering');

INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (23, 'Utvikle arbeidsmiljøet', 'AKTIV', 8, 18, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Vi har nå nødvendig kompetanse til å gjøre tiltak og forbedre arbeidsmiljøet vårt',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f406-8d6e-7d99-8000-c6bc53bd0910');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Vi har utarbeidet konkrete planer for hvordan vi skal jobbe systematisk med arbeidsmiljøet',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f406-8d6e-7d99-8000-c6bc53bd0910');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Vi har fått god forståelse for hvilke faktorer som påvirker arbeidsmiljøet vårt',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f406-8d6e-7d99-8000-c6bc53bd0910');INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (24, 'Endring og omstilling', 'AKTIV', 9, 18, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Vi har etablert rutiner for medvirkning og forebygging under endrings- og omstillingsprosesser',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f406-8d6e-7d99-8000-c6bc53bd0910');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Vi har nødvendig kompetanse for å forebygge sykefravær under omstillingsprosesser',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f406-8d6e-7d99-8000-c6bc53bd0910');INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (25, 'Oppfølging av arbeidsmiljøundersøkelser', 'AKTIV', 10, 18, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Vi har fått tilstrekkelig støtte til å gjennomføre tiltak basert på egen arbeidsmiljøundersøkelse',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f406-8d6e-7d99-8000-c6bc53bd0910');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Vi har opparbeidet oss nødvendig kompetanse til å følge opp fremtidige arbeidsmiljøundersøkelser',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f406-8d6e-7d99-8000-c6bc53bd0910');INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (26, 'Livsfaseorientert personalpolitikk', 'AKTIV', 11, 18, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Vi har en personalpolitikk som ivaretar ansattes behov i ulike deler av livet (f.eks. graviditet, førpensjon)',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f406-8d6e-7d99-8000-c6bc53bd0910');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Vi har utarbeidet gode rutiner for hvordan vi tilrettelegger ansattes arbeid i ulike deler av livet',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f406-8d6e-7d99-8000-c6bc53bd0910');INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (27, 'Psykisk helse', 'AKTIV', 12, 18, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Vi får tilbakemeldinger om at ansatte med psykiske plager blir godt ivaretatt',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f406-8d6e-7d99-8000-c6bc53bd0910');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Som leder, tillitsvalgt eller verneombud har jeg opparbeidet meg ferdigheter til å møte og støtte ansatte med psykiske plager',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f406-8d6e-7d99-8000-c6bc53bd0910');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Vi jobber kontinuerlig for å redusere stigma rundt psykiske plager',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f406-8d6e-7d99-8000-c6bc53bd0910');INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (28, 'HelseIArbeid', 'AKTIV', 13, 18, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Vi har fått økt kompetanse om tilrettelegging for ansatte med muskel-, skjelett- og psykiske plager',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f406-8d6e-7d99-8000-c6bc53bd0910');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Ansatte ønsker i større grad å jobbe til tross for muskel-, skjelett- og psykiske plager',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f406-8d6e-7d99-8000-c6bc53bd0910');INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (29, 'Veien videre', 'AKTIV', 14, 18, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Vi har opparbeidet oss et godt grunnlag for å jobbe videre med arbeidsmiljøet vårt',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f406-8d6e-7d99-8000-c6bc53bd0910');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f406-8d6e-7d99-8000-c6bc53bd0910','Vi har utarbeidet konkrete planer for hvordan vi skal videreutvikle arbeidsmiljøet vårt',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d73-71d2-8000-5c47f826fd0d', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d78-75d7-8000-766366d3bf43', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d7d-7901-8000-bce210c8292f', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d82-7bf9-8000-b2c1073c48f6', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f406-8d87-7e9d-8000-9f8396f17cae', '0673f406-8d6e-7d99-8000-c6bc53bd0910', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f406-8d6e-7d99-8000-c6bc53bd0910');