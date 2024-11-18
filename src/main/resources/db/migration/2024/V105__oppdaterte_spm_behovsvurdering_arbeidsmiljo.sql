-- Deaktiver gamelt tema ARBEIDSMILJØ med temaId 12
UPDATE ia_sak_kartlegging_tema
SET status = 'INAKTIV'
WHERE tema_id = 12;

-- Legg til ny versjon av Arbeidsmiljø
INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, status, rekkefolge, type)
VALUES (15, 'Arbeidsmiljø', 'AKTIV', 3, 'Behovsvurdering');

-- spm 1 Arbeidsmiljø
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01933f70-f3a6-790a-a75e-6cb280a7ec98',
        'Vi er kjent med de vanlige risikofaktorene i bransjen vår',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f71-d760-7d5f-9fcb-b0f2eb30126f', '01933f70-f3a6-790a-a75e-6cb280a7ec98', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f71-ef99-75b1-86a9-a515f47ed8fe', '01933f70-f3a6-790a-a75e-6cb280a7ec98', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f72-055a-7ce5-a808-4cfee18e0370', '01933f70-f3a6-790a-a75e-6cb280a7ec98', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f72-1830-72d6-bd6d-dc6746c6a002', '01933f70-f3a6-790a-a75e-6cb280a7ec98', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f72-2a39-77ca-8afd-7614de3d18c7', '01933f70-f3a6-790a-a75e-6cb280a7ec98', 'Vet ikke');

-- spm 2 Arbeidsmiljø
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01933f72-71e8-794c-b0bd-f163a178e955',
        'Vi har nødvendig kompetanse for å gjøre tiltak for å forbedre arbeidsmiljøet',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f72-9e54-7e66-86cb-6c498dfe5bf5', '01933f72-71e8-794c-b0bd-f163a178e955', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f72-bacf-799d-aece-f40790840c28', '01933f72-71e8-794c-b0bd-f163a178e955', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f72-ce54-7aa7-a888-1ba1996572da', '01933f72-71e8-794c-b0bd-f163a178e955', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f72-e083-7d34-b2b5-55687bee525a', '01933f72-71e8-794c-b0bd-f163a178e955', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f72-f218-7fd2-9fa0-8373b1cd2437', '01933f72-71e8-794c-b0bd-f163a178e955', 'Vet ikke');

-- spm 3 Arbeidsmiljø
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01933f73-1df4-7f5b-9273-b806e4cc6fda',
        'Vi jobber systematisk med utvikling av arbeidsmiljøet vårt',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f73-40c6-7e0a-aa16-2f3249450897', '01933f73-1df4-7f5b-9273-b806e4cc6fda', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f73-59d0-7206-b35b-4e79599166a8', '01933f73-1df4-7f5b-9273-b806e4cc6fda', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f73-6de9-762d-978b-2ee1b7dd6266', '01933f73-1df4-7f5b-9273-b806e4cc6fda', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f73-80f6-75c1-99d2-c81360ffc52d', '01933f73-1df4-7f5b-9273-b806e4cc6fda', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f73-94c3-729a-b65a-efcb833b3665', '01933f73-1df4-7f5b-9273-b806e4cc6fda', 'Vet ikke');

-- spm 4 Arbeidsmiljø
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01933f73-aec8-7efb-9803-2595ebb9fb1c',
        'På arbeidsplassen vår blir ansatte med psykiske plager godt ivaretatt',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f73-f9bd-7baa-8d38-d02c0f67dc27', '01933f73-aec8-7efb-9803-2595ebb9fb1c', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f74-0ba7-7596-be91-f46916a28453', '01933f73-aec8-7efb-9803-2595ebb9fb1c', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f74-2170-7bc1-9770-a7ed33719b47', '01933f73-aec8-7efb-9803-2595ebb9fb1c', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f74-35a9-76bb-9289-da5093fd0ddd', '01933f73-aec8-7efb-9803-2595ebb9fb1c', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f74-4733-7f28-858d-182c9c8e9184', '01933f73-aec8-7efb-9803-2595ebb9fb1c', 'Vet ikke');

-- Legg til alle 4 spm i tema Arbeidsmiljø
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (15, '01933f70-f3a6-790a-a75e-6cb280a7ec98');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (15, '01933f72-71e8-794c-b0bd-f163a178e955');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (15, '01933f73-1df4-7f5b-9273-b806e4cc6fda');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (15, '01933f73-aec8-7efb-9803-2595ebb9fb1c');
