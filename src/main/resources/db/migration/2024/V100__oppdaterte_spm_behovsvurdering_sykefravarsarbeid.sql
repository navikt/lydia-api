-- Deaktiver gamelt tema SYKEFRAVARSARBEID med temaId 5
UPDATE ia_sak_kartlegging_tema
SET status = 'INAKTIV'
WHERE tema_id = 5;

-- Legg til ny versjon av Sykefraværsarbeid
INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, status, rekkefolge, type)
VALUES (11, 'Sykefraværsarbeid', 'AKTIV', 2, 'Behovsvurdering');

-- spm 1 Sykefraværsarbeid
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01932f99-10b7-7533-9b8f-06c7d6feae2a',
        'Vi jobber systematisk for å forebygge sykefravær',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f99-10b7-7533-9b8f-06c7d6feae2a', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f99-10b7-7533-9b8f-06c7d6feae2a', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f99-10b7-7533-9b8f-06c7d6feae2a', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f99-10b7-7533-9b8f-06c7d6feae2a', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f99-10b7-7533-9b8f-06c7d6feae2a', 'Vet ikke');


-- spm 2 Sykefraværsarbeid
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01932f9b-bec9-781c-94ff-245a7361b6b3',
        'Vi har sykefraværsrutiner som fungerer godt',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f9b-bec9-781c-94ff-245a7361b6b3', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f9b-bec9-781c-94ff-245a7361b6b3', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f9b-bec9-781c-94ff-245a7361b6b3', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f9b-bec9-781c-94ff-245a7361b6b3', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f9b-bec9-781c-94ff-245a7361b6b3', 'Vet ikke');

-- spm 3 Sykefraværsarbeid
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01932fa0-39cd-7d52-9384-05978bb19d47',
        'Ansatte kjenner til egne plikter og rettigheter når de er sykmeldt eller står i fare for å bli det',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fa0-39cd-7d52-9384-05978bb19d47', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fa0-39cd-7d52-9384-05978bb19d47', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fa0-39cd-7d52-9384-05978bb19d47', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fa0-39cd-7d52-9384-05978bb19d47', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fa0-39cd-7d52-9384-05978bb19d47', 'Vet ikke');

-- spm 4 Sykefraarsarbeid
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01932fa0-e0cc-70f5-a22e-d410c19e8bf1',
        'Jeg opplever at ledere er trygge på å følge opp ansatte som er sykmeldt eller står i fare for å bli det',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fa0-e0cc-70f5-a22e-d410c19e8bf1', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fa0-e0cc-70f5-a22e-d410c19e8bf1', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fa0-e0cc-70f5-a22e-d410c19e8bf1', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fa0-e0cc-70f5-a22e-d410c19e8bf1', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fa0-e0cc-70f5-a22e-d410c19e8bf1', 'Vet ikke');

-- spm 5 Sykefraværsarbeid
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01932fa1-5719-7bb0-bb01-d6c8483c3aa0',
        'Vi har skriftlig oversikt over tilretteleggingsmuligheter for ansatte',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fa1-5719-7bb0-bb01-d6c8483c3aa0', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fa1-5719-7bb0-bb01-d6c8483c3aa0', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fa1-5719-7bb0-bb01-d6c8483c3aa0', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fa1-5719-7bb0-bb01-d6c8483c3aa0', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fa1-5719-7bb0-bb01-d6c8483c3aa0', 'Vet ikke');

-- spm 6 Sykefraarsarbeid
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01932fa2-63f0-7522-9c97-88386d9d9ba1',
        'Tilretteleggingstiltak er midlertidig og avsluttes til avtalt tid ',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fa2-63f0-7522-9c97-88386d9d9ba1', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fa2-63f0-7522-9c97-88386d9d9ba1', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fa2-63f0-7522-9c97-88386d9d9ba1', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fa2-63f0-7522-9c97-88386d9d9ba1', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fa2-63f0-7522-9c97-88386d9d9ba1', 'Vet ikke');

-- spm 7 Sykefraværsarbeid
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01932fa2-d2fe-7198-8ce7-cbc279d1828e',
        'Vi har mange vanskelige saker som handler om enkeltpersoners sykefravær',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fa2-d2fe-7198-8ce7-cbc279d1828e', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fa2-d2fe-7198-8ce7-cbc279d1828e', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fa2-d2fe-7198-8ce7-cbc279d1828e', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fa2-d2fe-7198-8ce7-cbc279d1828e', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932fa2-d2fe-7198-8ce7-cbc279d1828e', 'Vet ikke');

-- legg til alle 7 spm i tema Sykefraværsarbeid
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (11, '01932f99-10b7-7533-9b8f-06c7d6feae2a');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (11, '01932f9b-bec9-781c-94ff-245a7361b6b3');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (11, '01932fa0-39cd-7d52-9384-05978bb19d47');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (11, '01932fa0-e0cc-70f5-a22e-d410c19e8bf1');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (11, '01932fa1-5719-7bb0-bb01-d6c8483c3aa0');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (11, '01932fa2-63f0-7522-9c97-88386d9d9ba1');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (11, '01932fa2-d2fe-7198-8ce7-cbc279d1828e');

