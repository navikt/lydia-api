-- Deaktiver gamelt tema PARTSSAMARBEID med temaId 10
UPDATE ia_sak_kartlegging_tema
SET status = 'INAKTIV'
WHERE tema_id = 10;

-- Legg til ny versjon av Partssamarbeid
INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, status, rekkefolge, type)
VALUES (13, 'Partssamarbeid', 'AKTIV', 1, 'Behovsvurdering');

-- spm 1 Partssamarbeid
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01933f08-bdf8-795e-a8e3-5a892e075632',
        'Vi planlegger og gjennomfører jevnlige møter i partssamarbeidet',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f19-281f-7c7f-9d39-8ae56d58feb3', '01933f08-bdf8-795e-a8e3-5a892e075632', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f19-4d31-7fa8-88da-e5c63774a97a', '01933f08-bdf8-795e-a8e3-5a892e075632', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f19-ff1d-74d4-869c-7064e2bfd5bf', '01933f08-bdf8-795e-a8e3-5a892e075632', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f1a-23e7-71e9-a2b0-02c8fae5eeb9', '01933f08-bdf8-795e-a8e3-5a892e075632', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f1a-5669-7c9b-a3b8-b83edb6b36db', '01933f08-bdf8-795e-a8e3-5a892e075632', 'Vet ikke');


-- spm 2 Partssamarbeid
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01933f0f-4009-7838-b1b5-2d49e561dc5d',
        'Hvilke temaer vektlegges mest i møtene?',
        true);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f1b-35ee-7d27-ab57-548fc2e1a1c4', '01933f0f-4009-7838-b1b5-2d49e561dc5d', 'Lønnsforhandlinger');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f1b-4c98-7c3f-8828-0bf4532a345f', '01933f0f-4009-7838-b1b5-2d49e561dc5d', 'HMS');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f1b-6201-716a-b8f3-50538b854103', '01933f0f-4009-7838-b1b5-2d49e561dc5d', 'Drift og bemanning');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f1b-774b-7adc-b8c3-7b4749a13833', '01933f0f-4009-7838-b1b5-2d49e561dc5d', 'Sykefravær (f.eks. rutiner, tilrettelegging, oppfølging)');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f1b-8ec9-7647-8279-bfb05f0e13cb', '01933f0f-4009-7838-b1b5-2d49e561dc5d', 'Arbeidsmiljø (f.eks. organisering, planlegging)');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f1b-a21b-7073-a4d0-2e04368c7891', '01933f0f-4009-7838-b1b5-2d49e561dc5d', 'Personalpolitikk');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f1b-b2e3-768b-90ed-b506bd366ada', '01933f0f-4009-7838-b1b5-2d49e561dc5d', 'Velferdsgoder');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f1b-c493-7191-a9bc-1601f49257e0', '01933f0f-4009-7838-b1b5-2d49e561dc5d', 'Annet');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f1b-d3c9-758a-b732-1bf520afaafe', '01933f0f-4009-7838-b1b5-2d49e561dc5d', 'Vet ikke ');

-- spm 3 Partssamarbeid
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01933f1c-7601-7c68-aef3-b4e50b926cdc',
        'Hvordan opplever du at partssamarbeidet fungerer?',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f1d-14ab-7001-b1df-f8afc3d24b2e', '01933f1c-7601-7c68-aef3-b4e50b926cdc', 'Svært bra');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f1d-2af2-7a20-b3bc-73abd29eba60', '01933f1c-7601-7c68-aef3-b4e50b926cdc', 'Bra');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f1d-4b18-7ec1-92cb-56aa49ded239', '01933f1c-7601-7c68-aef3-b4e50b926cdc', 'Dårlig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f1d-9500-783b-b96c-730d00c426a0', '01933f1c-7601-7c68-aef3-b4e50b926cdc', 'Svært dårlig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f1d-ad77-756a-9fd6-420692d76056', '01933f1c-7601-7c68-aef3-b4e50b926cdc', 'Vet ikke');

-- spm 4 Partssamarbeid
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('01933f1d-dcdb-709c-a1f0-f5bf1982642b',
        'Som leder, tillitsvalgt eller verneombud har jeg god forståelse av min rolle og mine ansvarsområder i partssamarbeidet',
        false);

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f1e-575d-7ba0-af28-bba512737d9f', '01933f1d-dcdb-709c-a1f0-f5bf1982642b', 'Helt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f1e-6e85-7069-a6d9-4bcdca037eda', '01933f1d-dcdb-709c-a1f0-f5bf1982642b', 'Litt enig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f1e-86f8-7d19-91b6-bda5e3476df6', '01933f1d-dcdb-709c-a1f0-f5bf1982642b', 'Litt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f1e-9b03-702f-b028-b03926d1d5fd', '01933f1d-dcdb-709c-a1f0-f5bf1982642b', 'Helt uenig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES ('01933f1e-b4c4-7f2c-968e-6f681d1b0182', '01933f1d-dcdb-709c-a1f0-f5bf1982642b', 'Vet ikke');


-- Legg til alle 4 spørsmål i tema PARTSSAMARBEID
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (13, '01933f08-bdf8-795e-a8e3-5a892e075632');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (13, '01933f0f-4009-7838-b1b5-2d49e561dc5d');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (13, '01933f1c-7601-7c68-aef3-b4e50b926cdc');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (13, '01933f1d-dcdb-709c-a1f0-f5bf1982642b');