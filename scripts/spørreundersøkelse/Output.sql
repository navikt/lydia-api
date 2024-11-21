UPDATE ia_sak_kartlegging_tema
SET status = 'INAKTIV'
WHERE tema_id = 12;

-- Nytt tema

INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, status, rekkefolge, type)
VALUES (16, 'Partssamarbeid', 'AKTIV', 1, 'Evaluering');



INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (16, 'Utvikle partssamarbeidet', 'AKTIV', 1, 16, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Hvordan opplever du at partssamarbeidet har utviklet seg i løpet av samarbeidsperioden?',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffaf-7933-8000-e5f29364f2aa', '0673f422-ff88-7aac-8000-fed634597e1c', 'Svært godt');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffb4-7c2b-8000-2ce0e9542607', '0673f422-ff88-7aac-8000-fed634597e1c', 'Godt');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffb9-7f01-8000-189f23ca1413', '0673f422-ff88-7aac-8000-fed634597e1c', 'Dårlig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffbf-71a5-8000-0677e1346c9c', '0673f422-ff88-7aac-8000-fed634597e1c', 'Svært dårlig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffc4-746b-8000-df9ddd86f8c2', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (16, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Som leder, tillitsvalgt eller verneombud har jeg fått en bedre forståelse av min rolle og mine ansvarsområder i partssamarbeidet',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (16, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Vi har opparbeidet oss nødvendig kompetanse for å forebygge og håndtere sykefraværet vårt',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (16, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (17, 'Veien videre', 'AKTIV', 2, 16, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Vi har laget konkrete planer for hvordan vi i partssamarbeidet skal jobbe fremover',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (16, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Jeg opplever at vi er motiverte for å samarbeide videre om sykefravær og arbeidsmiljø',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (16, '0673f422-ff88-7aac-8000-fed634597e1c');

-- Nytt tema

INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, status, rekkefolge, type)
VALUES (17, 'Sykefraværsarbeid', 'AKTIV', 2, 'Evaluering');



INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (18, 'Sykefraværsrutiner', 'AKTIV', 3, 17, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Vi jobber nå mer systematisk for å forebygge sykefraværet vårt',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Vi har godt etablerte og lett tilgjengelige sykefraværsrutiner',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Ansatte kjenner til egne plikter og rettigheter når de er sykmeldt eller står i fare for å bli det',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (19, 'Oppfølgingssamtaler', 'AKTIV', 4, 17, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Jeg opplever at ledere er trygge under oppfølgingsamtaler med ansatte som er sykmeldt eller står i fare for å bli det',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (20, 'Tilretteleggings- og medvirkningsplikt', 'AKTIV', 5, 17, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Vi har utarbeidet og tilgjengeliggjort en oversikt over våre tilretteleggingsmuligheter',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Vi har etablerte rutiner og god kultur for tilrettelegging for ansatte',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Ansatte medvirker under tilrettelegging av arbeidsoppgaver',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (21, 'Sykefravær - enkeltsaker', 'AKTIV', 6, 17, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Vi har nødvendig kompetanse for å håndtere vanskelige sykefraværssaker',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (22, 'Veien videre', 'AKTIV', 7, 17, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Vi vet hvor vi finner gode verktøy i arbeidet med å redusere sykefraværet vårt',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Jeg tror videre forebyggende sykefraværsarbeid vil bidra til å redusere sykefraværet hos oss',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (17, '0673f422-ff88-7aac-8000-fed634597e1c');

-- Nytt tema

INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, status, rekkefolge, type)
VALUES (18, 'Arbeidsmiljø', 'AKTIV', 3, 'Evaluering');



INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (23, 'Utvikle arbeidsmiljøet', 'AKTIV', 8, 18, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Vi har nå nødvendig kompetanse til å gjøre tiltak og forbedre arbeidsmiljøet vårt',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Vi har utarbeidet konkrete planer for hvordan vi skal jobbe systematisk med arbeidsmiljøet',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Vi har fått god forståelse for hvilke faktorer som påvirker arbeidsmiljøet vårt',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (24, 'Endring og omstilling', 'AKTIV', 9, 18, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Vi har etablert rutiner for medvirkning og forebygging under endrings- og omstillingsprosesser',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Vi har nødvendig kompetanse for å forebygge sykefravær under omstillingsprosesser',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (25, 'Oppfølging av arbeidsmiljøundersøkelser', 'AKTIV', 10, 18, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Vi har fått tilstrekkelig støtte til å gjennomføre tiltak basert på egen arbeidsmiljøundersøkelse',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Vi har opparbeidet oss nødvendig kompetanse til å følge opp fremtidige arbeidsmiljøundersøkelser',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (26, 'Livsfaseorientert personalpolitikk', 'AKTIV', 11, 18, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Vi har en personalpolitikk som ivaretar ansattes behov i ulike deler av livet (f.eks. graviditet, førpensjon)',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Vi har utarbeidet gode rutiner for hvordan vi tilrettelegger ansattes arbeid i ulike deler av livet',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (27, 'Psykisk helse', 'AKTIV', 12, 18, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Vi får tilbakemeldinger om at ansatte med psykiske plager blir godt ivaretatt',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Som leder, tillitsvalgt eller verneombud har jeg opparbeidet meg ferdigheter til å møte og støtte ansatte med psykiske plager',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Vi jobber kontinuerlig for å redusere stigma rundt psykiske plager',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (28, 'HelseIArbeid', 'AKTIV', 13, 18, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Vi har fått økt kompetanse om tilrettelegging for ansatte med muskel-, skjelett- og psykiske plager',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Ansatte ønsker i større grad å jobbe til tross for muskel-, skjelett- og psykiske plager',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (29, 'Veien videre', 'AKTIV', 14, 18, false);

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Vi har opparbeidet oss et godt grunnlag for å jobbe videre med arbeidsmiljøet vårt',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f422-ff88-7aac-8000-fed634597e1c');

INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0673f422-ff88-7aac-8000-fed634597e1c','Vi har utarbeidet konkrete planer for hvordan vi skal videreutvikle arbeidsmiljøet vårt',false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff8d-7ec1-8000-c6abca5076a1', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff93-737e-8000-663497c36f7a', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff98-76a8-8000-7a0d514f8623', '0673f422-ff88-7aac-8000-fed634597e1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ff9d-79e4-8000-e9dd82c52338', '0673f422-ff88-7aac-8000-fed634597e1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0673f422-ffa2-7cba-8000-5b359f03e0ed', '0673f422-ff88-7aac-8000-fed634597e1c', 'Vet ikke');


INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (18, '0673f422-ff88-7aac-8000-fed634597e1c');