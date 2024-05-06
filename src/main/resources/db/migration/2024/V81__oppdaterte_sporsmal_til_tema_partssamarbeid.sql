-- Deaktiver gammelt tema PARTSSAMARBEID med temaId 3
UPDATE ia_sak_kartlegging_tema SET status = 'INAKTIV' WHERE tema_id = 3;

-- Legg til ny versjon av tema PARTSSAMARBEID
INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, rekkefolge, beskrivelse, introtekst)
VALUES (4, 'UTVIKLE_PARTSSAMARBEID', 1,
        'Partssamarbeid',
        '');

-- spm 1 med 6 svaralternativer
insert into ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('018f4e25-6a40-79c6-bb29-68de8b575cd1',
        'Vi planlegger og gjennomfører jevnlige møter i partssamarbeidet',
        false);
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-79c6-bb29-68de8b575cd1', 'Enig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-79c6-bb29-68de8b575cd1', 'Litt enig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-79c6-bb29-68de8b575cd1', 'Hverken enig eller uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-79c6-bb29-68de8b575cd1', 'Litt uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-79c6-bb29-68de8b575cd1', 'Uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-79c6-bb29-68de8b575cd1', 'Vet ikke');

-- spm 2 med 8 svaralternativer (flervalg)
insert into ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('018f4e25-6a40-713f-b769-267afa134896',
        'Hvilke temaer vektlegges mest i møtene?',
        true);
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-713f-b769-267afa134896', 'Lønnsforhandlinger');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-713f-b769-267afa134896', 'HMS');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-713f-b769-267afa134896', 'Rekruttering og bemanning');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-713f-b769-267afa134896', 'Driftsrelaterte saker (f.eks. utvikling, økonomi)');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-713f-b769-267afa134896',
        'Sykefravær (f.eks. rutiner, tilrettelegging, oppfølging)');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-713f-b769-267afa134896', 'Arbeidsmiljø (f.eks. organisering, planlegging)');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-713f-b769-267afa134896', 'Annet');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-713f-b769-267afa134896', 'Vet ikke ');

-- spm 3 med 6 svaralternativer
insert into ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('018f4e25-6a40-7c73-8183-cc574b92b2be',
        'Hvordan opplever du at partssamarbeidet fungerer?',
        false);
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-7c73-8183-cc574b92b2be', 'Svært bra');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-7c73-8183-cc574b92b2be', 'Bra');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-7c73-8183-cc574b92b2be', 'Hverken bra eller dårlig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-7c73-8183-cc574b92b2be', 'Dårlig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-7c73-8183-cc574b92b2be', 'Svært dårlig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-7c73-8183-cc574b92b2be', 'Vet ikke');

-- spm 4 med 6 svaralternativer
insert into ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst, flervalg)
VALUES ('018f4e25-6a40-78d9-9ad6-775fec6a102f',
        'Som leder, tillitsvalgt eller verneombud jobber jeg for et godt samarbeid på arbeidsplassen',
        false);
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-78d9-9ad6-775fec6a102f', 'Enig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-78d9-9ad6-775fec6a102f', 'Litt enig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-78d9-9ad6-775fec6a102f', 'Hverken enig eller uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-78d9-9ad6-775fec6a102f', 'Litt uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-78d9-9ad6-775fec6a102f', 'Uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e25-6a40-78d9-9ad6-775fec6a102f', 'Vet ikke ');


-- Legg til alle 4 spørsmål i tema PARTSSAMARBEID
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (4, '018f4e25-6a40-79c6-bb29-68de8b575cd1');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (4, '018f4e25-6a40-713f-b769-267afa134896');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (4, '018f4e25-6a40-7c73-8183-cc574b92b2be');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (4, '018f4e25-6a40-78d9-9ad6-775fec6a102f');
