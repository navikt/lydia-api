-- Deaktiver 'Sykefraværsarbeid' med temaId 14
UPDATE ia_sak_kartlegging_tema
SET status = 'INAKTIV'
WHERE tema_id = 14;

-- Nytt tema -> 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, status, rekkefolge, type)
VALUES (20, 'Sykefraværsarbeid', 'AKTIV', 2, 'Behovsvurdering');

-- Nytt undertema -> 'Sykefraværsarbeid' : 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_undertema (undertema_id, navn, status, rekkefolge, tema_id, obligatorisk)
VALUES (31, 'Sykefraværsarbeid', 'AKTIV', 1, 20, false);

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0193aabd-2eca-787b-922f-8333040f5b0d',
        'Vi jobber systematisk for å forebygge sykefravær',
        false);
-- Knytt spørsmål til undertema -> 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (31, '0193aabd-2eca-787b-922f-8333040f5b0d', 1);

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aabd-429f-7daa-bda8-53e97865a9ac', '0193aabd-2eca-787b-922f-8333040f5b0d', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aabd-559a-7463-a779-ed9513b9ec04', '0193aabd-2eca-787b-922f-8333040f5b0d', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aabd-65f9-77a1-bbe8-f3765c3a04f7', '0193aabd-2eca-787b-922f-8333040f5b0d', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aabd-77c7-777c-b7cd-7c9d7facbbec', '0193aabd-2eca-787b-922f-8333040f5b0d', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aabd-9034-753f-b9c0-0b24b571d9f1', '0193aabd-2eca-787b-922f-8333040f5b0d', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0193aac0-431c-7bc9-b62b-3bc0617c92ec',
        'Vi har sykefraværsrutiner som fungerer godt',
        false);
-- Knytt spørsmål til undertema -> 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (31, '0193aac0-431c-7bc9-b62b-3bc0617c92ec', 2);

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aac0-614f-7399-93ff-af204c983ce4', '0193aac0-431c-7bc9-b62b-3bc0617c92ec', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aac0-6f34-7b69-8754-5d42ce7e9db6', '0193aac0-431c-7bc9-b62b-3bc0617c92ec', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aac0-83ed-72d0-8346-1a683e2d9be8', '0193aac0-431c-7bc9-b62b-3bc0617c92ec', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aac0-9bb9-7b8e-ba7c-a3d9b584e262', '0193aac0-431c-7bc9-b62b-3bc0617c92ec', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aac0-abe0-7803-a759-c85182f2db52', '0193aac0-431c-7bc9-b62b-3bc0617c92ec', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0193aac3-b00b-72e5-ae46-9e546fef3d5f',
        'Ansatte kjenner til egne plikter og rettigheter når de er sykmeldt eller står i fare for å bli det',
        false);
-- Knytt spørsmål til undertema -> 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (31, '0193aac3-b00b-72e5-ae46-9e546fef3d5f', 3);

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aac3-c5f7-7db9-b3d9-53cb4c0f6b6a', '0193aac3-b00b-72e5-ae46-9e546fef3d5f', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aac3-d692-7466-9fb5-c1916630b99c', '0193aac3-b00b-72e5-ae46-9e546fef3d5f', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aac3-f0ef-7993-9146-8445340e4a5e', '0193aac3-b00b-72e5-ae46-9e546fef3d5f', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aac4-04f3-70f2-b449-e7edaa436fdd', '0193aac3-b00b-72e5-ae46-9e546fef3d5f', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aac4-4afa-7763-bfb8-f31d63321636', '0193aac3-b00b-72e5-ae46-9e546fef3d5f', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0193aac7-72d3-7e26-9846-80cc0f76b292',
        'Jeg opplever at ledere er trygge på å følge opp ansatte som er sykmeldt eller står i fare for å bli det',
        false);
-- Knytt spørsmål til undertema -> 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (31, '0193aac7-72d3-7e26-9846-80cc0f76b292', 4);

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aac7-8855-7b1e-a0f3-757eb5247c18', '0193aac7-72d3-7e26-9846-80cc0f76b292', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aac7-9f87-7662-af5f-22028be9b664', '0193aac7-72d3-7e26-9846-80cc0f76b292', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aac7-b2f5-78a0-9c46-7b71c046fec4', '0193aac7-72d3-7e26-9846-80cc0f76b292', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aac7-c402-76d3-972f-5997d6cc3341', '0193aac7-72d3-7e26-9846-80cc0f76b292', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aac7-dcf3-70bc-be76-665f697872a7', '0193aac7-72d3-7e26-9846-80cc0f76b292', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0193aac9-bd28-7d08-a907-f8d09c3b4dca',
        'Vi har skriftlig oversikt over tilretteleggingsmuligheter for ansatte',
        false);
-- Knytt spørsmål til undertema -> 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (31, '0193aac9-bd28-7d08-a907-f8d09c3b4dca', 5);

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aac9-cfe3-7b80-b0d6-b688f6ba3347', '0193aac9-bd28-7d08-a907-f8d09c3b4dca', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aac9-dff1-7640-bd72-bd118b50e5e3', '0193aac9-bd28-7d08-a907-f8d09c3b4dca', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aaca-06ce-71f9-9f84-7c47da37c5f4', '0193aac9-bd28-7d08-a907-f8d09c3b4dca', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aaca-1908-70f5-bb04-43d119c03d92', '0193aac9-bd28-7d08-a907-f8d09c3b4dca', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aaca-3406-7111-97a5-95fd6b809560', '0193aac9-bd28-7d08-a907-f8d09c3b4dca', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0193aacc-2675-77eb-8bf3-f3a5de82ad38',
        'Tilretteleggingstiltak er midlertidig og avsluttes til avtalt tid',
        false);
-- Knytt spørsmål til undertema -> 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (31, '0193aacc-2675-77eb-8bf3-f3a5de82ad38', 6);

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aacc-391c-7007-9f40-a6a58c68e2b0', '0193aacc-2675-77eb-8bf3-f3a5de82ad38', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aacc-47ce-7946-b04c-e44108a7cfcb', '0193aacc-2675-77eb-8bf3-f3a5de82ad38', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aacc-5a18-71af-a443-831f596c3274', '0193aacc-2675-77eb-8bf3-f3a5de82ad38', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aacc-695a-7a75-acb3-2d7c9734b5a8', '0193aacc-2675-77eb-8bf3-f3a5de82ad38', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aacc-785f-7971-93a1-dc4baacb9003', '0193aacc-2675-77eb-8bf3-f3a5de82ad38', 'Vet ikke');

-- Nytt spørsmål for undertema -> 'Sykefraværsarbeid' : 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('0193aacf-95ba-7115-8282-b986f6dbbe86',
        'Vi har vanskelige saker som handler om enkeltpersoners sykefravær',
        false);
-- Knytt spørsmål til undertema -> 'Sykefraværsarbeid'
INSERT INTO ia_sak_kartlegging_sporsmal_til_undertema (undertema_id, sporsmal_id,rekkefolge)
VALUES (31, '0193aacf-95ba-7115-8282-b986f6dbbe86', 7);

-- Svaralternativer:
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aacf-acaa-7377-a78c-c4a4ff5da529', '0193aacf-95ba-7115-8282-b986f6dbbe86', 'Enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aacf-c3ab-73c3-aeb8-e53f2ab41dd2', '0193aacf-95ba-7115-8282-b986f6dbbe86', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aacf-d4ee-7b49-b473-257b713740a4', '0193aacf-95ba-7115-8282-b986f6dbbe86', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aacf-efb5-76c2-b57d-a0b64d6d47f5', '0193aacf-95ba-7115-8282-b986f6dbbe86', 'Uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('0193aad0-021a-733e-9cdb-8bd5d9958149', '0193aacf-95ba-7115-8282-b986f6dbbe86', 'Vet ikke');