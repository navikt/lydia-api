-- deaktiver gammelt tema REDUSERE_SYKEFRAVÆR med temaId 2
UPDATE ia_sak_kartlegging_tema
SET status = 'INAKTIV'
WHERE tema_id = 2;

-- legg til nytt navn og ny versjon av tema REDUSERE_SYKEFRAVÆR
INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, rekkefolge, beskrivelse, introtekst)
VALUES (5, 'REDUSERE_SYKEFRAVÆR', 2,
        'Sykefraværsarbeid',
        '');

-- spm 1
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst)
VALUES ('018f4e5d-c06d-775f-8304-8afa7bf193d1',
        'Vi jobber systematisk for å forebygge sykefravær');

insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5d-c06d-775f-8304-8afa7bf193d1', 'Enig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5d-c06d-775f-8304-8afa7bf193d1', 'Litt enig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5d-c06d-775f-8304-8afa7bf193d1', 'Hverken enig eller uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5d-c06d-775f-8304-8afa7bf193d1', 'Litt uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5d-c06d-775f-8304-8afa7bf193d1', 'Uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5d-c06d-775f-8304-8afa7bf193d1', 'Vet ikke');

-- spm 2
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst)
VALUES ('018f4e5e-18b2-7bf9-a714-ea5554f213d7',
        'Vi har sykefraværsrutiner som er kjent for alle og blir brukt');

insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-18b2-7bf9-a714-ea5554f213d7', 'Enig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-18b2-7bf9-a714-ea5554f213d7', 'Litt enig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-18b2-7bf9-a714-ea5554f213d7', 'Hverken enig eller uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-18b2-7bf9-a714-ea5554f213d7', 'Litt uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-18b2-7bf9-a714-ea5554f213d7', 'Uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-18b2-7bf9-a714-ea5554f213d7', 'Vet ikke');

-- spm 3
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst)
VALUES ('018f4e5e-51bb-7a64-9bca-452ab06ae313',
        'Ansatte kjenner til egne plikter og rettigheter når de er sykmeldt eller står i fare for å bli det');

insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-51bb-7a64-9bca-452ab06ae313', 'Enig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-51bb-7a64-9bca-452ab06ae313', 'Litt enig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-51bb-7a64-9bca-452ab06ae313', 'Hverken enig eller uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-51bb-7a64-9bca-452ab06ae313', 'Litt uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-51bb-7a64-9bca-452ab06ae313', 'Uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-51bb-7a64-9bca-452ab06ae313', 'Vet ikke');

-- spm 4
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst)
VALUES ('018f4e5e-6b80-7332-8491-359b2985d8a0',
        'Jeg opplever at ledere er trygge på å følge opp ansatte som er sykmeldt eller står i fare for å bli det');

insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-6b80-7332-8491-359b2985d8a0', 'Enig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-6b80-7332-8491-359b2985d8a0', 'Litt enig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-6b80-7332-8491-359b2985d8a0', 'Hverken enig eller uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-6b80-7332-8491-359b2985d8a0', 'Litt uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-6b80-7332-8491-359b2985d8a0', 'Uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-6b80-7332-8491-359b2985d8a0', 'Vet ikke');

-- spm 5
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst)
VALUES ('018f4e5e-84bf-7123-adb2-f80af15c954f',
        'Vi har skriftlig oversikt over tilretteleggingsmuligheter for ansatte');

insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-84bf-7123-adb2-f80af15c954f', 'Enig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-84bf-7123-adb2-f80af15c954f', 'Litt enig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-84bf-7123-adb2-f80af15c954f', 'Hverken enig eller uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-84bf-7123-adb2-f80af15c954f', 'Litt uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-84bf-7123-adb2-f80af15c954f', 'Uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-84bf-7123-adb2-f80af15c954f', 'Vet ikke');

-- spm 6
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst)
VALUES ('018f4e5e-9ce6-74c6-9e9d-c6a9b49075b9',
        'Tilretteleggingstiltak er midlertidig og avsluttes til avtalt tid ');

insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-9ce6-74c6-9e9d-c6a9b49075b9', 'Enig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-9ce6-74c6-9e9d-c6a9b49075b9', 'Litt enig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-9ce6-74c6-9e9d-c6a9b49075b9', 'Hverken enig eller uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-9ce6-74c6-9e9d-c6a9b49075b9', 'Litt uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-9ce6-74c6-9e9d-c6a9b49075b9', 'Uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-9ce6-74c6-9e9d-c6a9b49075b9', 'Vet ikke');

-- spm 7
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst)
VALUES ('018f4e5e-b178-7d83-aa0b-ddb52cade105',
        'Jeg har inntrykk av at vi har mange vanskelige enkeltsaker som handler om sykefravær');

insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-b178-7d83-aa0b-ddb52cade105', 'Enig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-b178-7d83-aa0b-ddb52cade105', 'Litt enig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-b178-7d83-aa0b-ddb52cade105', 'Hverken enig eller uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-b178-7d83-aa0b-ddb52cade105', 'Litt uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-b178-7d83-aa0b-ddb52cade105', 'Uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e5e-b178-7d83-aa0b-ddb52cade105', 'Vet ikke');

-- knytt alle spørsmålene til det nye temaet SYKEFRAVÆRSARBEID
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (5, '018f4e5d-c06d-775f-8304-8afa7bf193d1');

INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (5, '018f4e5e-18b2-7bf9-a714-ea5554f213d7');

INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (5, '018f4e5e-51bb-7a64-9bca-452ab06ae313');

INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (5, '018f4e5e-6b80-7332-8491-359b2985d8a0');

INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (5, '018f4e5e-84bf-7123-adb2-f80af15c954f');

INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (5, '018f4e5e-9ce6-74c6-9e9d-c6a9b49075b9');

INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (5, '018f4e5e-b178-7d83-aa0b-ddb52cade105');