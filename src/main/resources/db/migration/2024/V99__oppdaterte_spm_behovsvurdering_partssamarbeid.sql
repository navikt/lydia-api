-- Deaktiver gamelt tema PARTSSAMARBEID med temaId 4
UPDATE ia_sak_kartlegging_tema
SET status = 'INAKTIV'
WHERE tema_id = 4;

-- Legg til ny versjon av Partssamarbeid
INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, status, rekkefolge, type)
VALUES (10, 'Partssamarbeid', 'AKTIV', 1, 'Behovsvurdering');

-- spm 1 Partssamarbeid
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01932f4c-38f5-7083-a38d-41dc664866d3',
        'Vi planlegger og gjennomfører jevnlige møter i partssamarbeidet',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f4c-38f5-7083-a38d-41dc664866d3', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f4c-38f5-7083-a38d-41dc664866d3', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f4c-38f5-7083-a38d-41dc664866d3', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f4c-38f5-7083-a38d-41dc664866d3', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f4c-38f5-7083-a38d-41dc664866d3', 'Vet ikke');


-- spm 2 Partssamarbeid
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01932f59-7a00-7c2e-acb5-c6709503d92c',
        'Hvilke temaer vektlegges mest i møtene?',
        true);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f59-7a00-7c2e-acb5-c6709503d92c', 'Lønnsforhandlinger');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f59-7a00-7c2e-acb5-c6709503d92c', 'HMS');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f59-7a00-7c2e-acb5-c6709503d92c', 'Drift og bemanning');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f59-7a00-7c2e-acb5-c6709503d92c', 'Sykefravær (f.eks. rutiner, tilrettelegging, oppfølging)');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f59-7a00-7c2e-acb5-c6709503d92c', 'Arbeidsmiljø (f.eks. organisering, planlegging)');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f59-7a00-7c2e-acb5-c6709503d92c', 'Personalpolitikk');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f59-7a00-7c2e-acb5-c6709503d92c', 'Velferdsgoder');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f59-7a00-7c2e-acb5-c6709503d92c', 'Annet');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f59-7a00-7c2e-acb5-c6709503d92c', 'Vet ikke ');

-- spm 3 Partssamarbeid
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01932f63-597d-73c4-976b-723bba329c57',
        'Hvordan opplever du at partssamarbeidet fungerer?',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f63-597d-73c4-976b-723bba329c57', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f63-597d-73c4-976b-723bba329c57', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f63-597d-73c4-976b-723bba329c57', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f63-597d-73c4-976b-723bba329c57', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f63-597d-73c4-976b-723bba329c57', 'Vet ikke');

-- spm 4 Partssamarbeid
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01932f65-c95a-7bb5-b2b0-70099e2c6956',
        'Som leder, tillitsvalgt eller verneombud har jeg god forståelse av min rolle og mine ansvarsområder i partssamarbeidet',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f65-c95a-7bb5-b2b0-70099e2c6956', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f65-c95a-7bb5-b2b0-70099e2c6956', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f65-c95a-7bb5-b2b0-70099e2c6956', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f65-c95a-7bb5-b2b0-70099e2c6956', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f65-c95a-7bb5-b2b0-70099e2c6956', 'Vet ikke');


-- Legg til alle 4 spørsmål i tema PARTSSAMARBEID
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (10, '01932f4c-38f5-7083-a38d-41dc664866d3');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (10, '01932f59-7a00-7c2e-acb5-c6709503d92c');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (10, '01932f63-597d-73c4-976b-723bba329c57');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (10, '01932f65-c95a-7bb5-b2b0-70099e2c6956');