-- Deaktiver gamelt tema SYKEFRAVARSARBEID med temaId 11
UPDATE ia_sak_kartlegging_tema
SET status = 'INAKTIV'
WHERE tema_id = 11;

-- Legg til ny versjon av Sykefraværsarbeid
INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, status, rekkefolge, type)
VALUES (14, 'Sykefraværsarbeid', 'AKTIV', 2, 'Behovsvurdering');

-- spm 1 Sykefraværsarbeid
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01933f67-fdf2-77a7-adc0-f5900dbc99a5',
        'Vi jobber systematisk for å forebygge sykefravær',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f69-5391-7e79-8862-b179544dd97e', '01933f67-fdf2-77a7-adc0-f5900dbc99a5', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f69-678d-7591-9042-e7bc309224fc', '01933f67-fdf2-77a7-adc0-f5900dbc99a5', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f69-7a79-733e-983e-feaa04be783f', '01933f67-fdf2-77a7-adc0-f5900dbc99a5', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f69-8ef6-7cba-b431-5266cc2600bb', '01933f67-fdf2-77a7-adc0-f5900dbc99a5', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f69-a434-7c29-bef4-0091f4c05a40', '01933f67-fdf2-77a7-adc0-f5900dbc99a5', 'Vet ikke');


-- spm 2 Sykefraværsarbeid
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01933f69-e26d-75cc-a325-ad494cddff1f',
        'Vi har sykefraværsrutiner som fungerer godt',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6a-31a6-7cde-aaa5-3d0abc1a76c2', '01933f69-e26d-75cc-a325-ad494cddff1f', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6a-4b61-7c81-834c-9c49b9ed6753', '01933f69-e26d-75cc-a325-ad494cddff1f', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6a-5dd0-7ec6-a3ab-27b3eab4c826', '01933f69-e26d-75cc-a325-ad494cddff1f', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6a-85d7-7535-b36d-a2b27aa04299', '01933f69-e26d-75cc-a325-ad494cddff1f', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6a-95f9-7f69-8e3e-094cd43545da', '01933f69-e26d-75cc-a325-ad494cddff1f', 'Vet ikke');

-- spm 3 Sykefraværsarbeid
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01933f6a-bb81-7e10-814b-a56e67c969c9',
        'Ansatte kjenner til egne plikter og rettigheter når de er sykmeldt eller står i fare for å bli det',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6b-03b4-7f54-9f7c-bf3e37c792fc', '01933f6a-bb81-7e10-814b-a56e67c969c9', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6b-1393-79de-9ca8-f4f3a004d4a2', '01933f6a-bb81-7e10-814b-a56e67c969c9', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6b-4c84-74e5-ad11-9945f156167e', '01933f6a-bb81-7e10-814b-a56e67c969c9', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6b-68c0-79c6-9a39-2da8c0b0019d', '01933f6a-bb81-7e10-814b-a56e67c969c9', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6b-8564-706e-8f94-4b290d9c10e1', '01933f6a-bb81-7e10-814b-a56e67c969c9', 'Vet ikke');

-- spm 4 Sykefraarsarbeid
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01933f6b-f83f-7916-b9c3-19e1b83f7ea4',
        'Jeg opplever at ledere er trygge på å følge opp ansatte som er sykmeldt eller står i fare for å bli det',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6c-3197-7312-8036-acca90a448e2', '01933f6b-f83f-7916-b9c3-19e1b83f7ea4', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6c-4364-740c-9279-1ae0cd5a8782', '01933f6b-f83f-7916-b9c3-19e1b83f7ea4', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6c-58dd-73bb-8c95-1da8cbc9797c', '01933f6b-f83f-7916-b9c3-19e1b83f7ea4', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6c-72f2-7a14-b751-cfb427db32de', '01933f6b-f83f-7916-b9c3-19e1b83f7ea4', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6c-88ab-7948-99f5-233d51421fe7', '01933f6b-f83f-7916-b9c3-19e1b83f7ea4', 'Vet ikke');

-- spm 5 Sykefraværsarbeid
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01933f6c-9e15-7bf6-a242-c955abc87769',
        'Vi har skriftlig oversikt over tilretteleggingsmuligheter for ansatte',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6d-0be9-722f-8900-9b02ecbfe2b6', '01933f6c-9e15-7bf6-a242-c955abc87769', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6d-2508-7075-99ad-8f98f4317a07', '01933f6c-9e15-7bf6-a242-c955abc87769', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6d-36b0-7dd2-b0b7-9f86417b74ab', '01933f6c-9e15-7bf6-a242-c955abc87769', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6d-4bf2-755a-bc0d-b01bc92fa7c9', '01933f6c-9e15-7bf6-a242-c955abc87769', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6d-6026-704e-8e29-79e7dfdcbead', '01933f6c-9e15-7bf6-a242-c955abc87769', 'Vet ikke');

-- spm 6 Sykefraarsarbeid
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01933f6d-8f1e-759f-8a27-f5a1434e5b67',
        'Tilretteleggingstiltak er midlertidig og avsluttes til avtalt tid ',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6d-bd51-771b-8389-b19d5e97e484', '01933f6d-8f1e-759f-8a27-f5a1434e5b67', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6d-d670-72bc-9da5-07170cd009f0', '01933f6d-8f1e-759f-8a27-f5a1434e5b67', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6d-e8f4-7f3c-ad04-63d74e033756', '01933f6d-8f1e-759f-8a27-f5a1434e5b67', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6d-fd58-7fe0-8f0f-8c3e0c88ee12', '01933f6d-8f1e-759f-8a27-f5a1434e5b67', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6e-0f29-7969-bb53-660167a1ec34', '01933f6d-8f1e-759f-8a27-f5a1434e5b67', 'Vet ikke');

-- spm 7 Sykefraværsarbeid
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01933f6e-38bc-72aa-8b41-8dccf7d50d64',
        'Vi har mange vanskelige saker som handler om enkeltpersoners sykefravær',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6e-8b39-7ae2-be47-62437fc3714b', '01933f6e-38bc-72aa-8b41-8dccf7d50d64', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6e-af8f-798e-ac0e-7716e69d9085', '01933f6e-38bc-72aa-8b41-8dccf7d50d64', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6e-c9a9-77a2-ad3a-43f805788f50', '01933f6e-38bc-72aa-8b41-8dccf7d50d64', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6e-dead-7197-adcc-4dbb98fd843c', '01933f6e-38bc-72aa-8b41-8dccf7d50d64', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f6f-19d4-72bd-9b9f-929beb7e9ad9', '01933f6e-38bc-72aa-8b41-8dccf7d50d64', 'Vet ikke');

-- legg til alle 7 spm i tema Sykefraværsarbeid
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (14, '01933f67-fdf2-77a7-adc0-f5900dbc99a5');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (14, '01933f69-e26d-75cc-a325-ad494cddff1f');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (14, '01933f6a-bb81-7e10-814b-a56e67c969c9');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (14, '01933f6b-f83f-7916-b9c3-19e1b83f7ea4');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (14, '01933f6c-9e15-7bf6-a242-c955abc87769');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (14, '01933f6d-8f1e-759f-8a27-f5a1434e5b67');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (14, '01933f6e-38bc-72aa-8b41-8dccf7d50d64');

