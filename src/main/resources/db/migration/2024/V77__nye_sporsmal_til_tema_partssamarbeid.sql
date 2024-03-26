-- spm 1
insert into ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst)
VALUES ('018e7b0a-4455-739d-b377-870e01fe978f',
        'Hvor lenge har du vært en del av gruppen?');

insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b0a-4455-739d-b377-870e01fe978f', 'Mindre enn et år');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b0a-4455-739d-b377-870e01fe978f', '1-2 år');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b0a-4455-739d-b377-870e01fe978f', '2-4 år');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b0a-4455-739d-b377-870e01fe978f', 'Mer enn fire år');

-- spm 2
insert into ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst)
VALUES ('018e7b0b-2490-7295-9ab4-aca881c46320',
        'Hvor ofte møtes dere?');

insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b0b-2490-7295-9ab4-aca881c46320', '1 - 2 ganger i året');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b0b-2490-7295-9ab4-aca881c46320', '3 - 5 ganger i året');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b0b-2490-7295-9ab4-aca881c46320', '6 - 10 ganger i året');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b0b-2490-7295-9ab4-aca881c46320', 'Mer enn 10 ganger i året');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b0b-2490-7295-9ab4-aca881c46320', 'Vet ikke');

-- spm 3

insert into ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst)
VALUES ('018e7b0d-fe32-79ab-8e2e-b990afbbc2bf',
        'Hvilke temaer får størst prioritet i møtene deres?');

insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b0d-fe32-79ab-8e2e-b990afbbc2bf', 'Lønnsforhandlinger');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b0d-fe32-79ab-8e2e-b990afbbc2bf', 'HMS');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b0d-fe32-79ab-8e2e-b990afbbc2bf', 'Bemanning');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b0d-fe32-79ab-8e2e-b990afbbc2bf', 'Sykefravær');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b0d-fe32-79ab-8e2e-b990afbbc2bf', 'Arbeidsmiljø');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b0d-fe32-79ab-8e2e-b990afbbc2bf', 'Annet');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b0d-fe32-79ab-8e2e-b990afbbc2bf', 'Vet ikke');

-- spm 4
insert into ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst)
VALUES ('018e7b12-b11a-7f68-b617-e694fd010088',
        'Hvor godt kjenner dere til hverandres roller og ansvar i gruppen?');

insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b12-b11a-7f68-b617-e694fd010088', 'Godt');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b12-b11a-7f68-b617-e694fd010088', 'Hverken godt eller dårlig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b12-b11a-7f68-b617-e694fd010088', 'Ikke så godt');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b12-b11a-7f68-b617-e694fd010088', 'Vet ikke');

-- spm 5
insert into ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst)
VALUES ('018e7b15-256d-705e-a3e9-913e56658b28',
        'Hvordan opplever du at samarbeidet i gruppen fungerer?');

insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b15-256d-705e-a3e9-913e56658b28', 'Bra');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b15-256d-705e-a3e9-913e56658b28', 'Hverken bra eller dårlig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b15-256d-705e-a3e9-913e56658b28', 'Ikke så bra');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b15-256d-705e-a3e9-913e56658b28', 'Vet ikke');

-- spm 6
insert into ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst)
VALUES ('018e7b17-4004-7c54-a1ab-d352a87be133',
        'I hvilken grad er du involvert i den daglige driften?');

insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b17-4004-7c54-a1ab-d352a87be133', 'I stor grad');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b17-4004-7c54-a1ab-d352a87be133', 'I noe grad');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b17-4004-7c54-a1ab-d352a87be133', 'I liten grad');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b17-4004-7c54-a1ab-d352a87be133', 'Vet ikke');

-- spm 7
insert into ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst)
VALUES ('018e7b18-2552-77e9-95a1-366c3eb8e800',
        'I hvilken grad er du involvert i å skape godt samarbeid på arbeidsplassen?');

insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b18-2552-77e9-95a1-366c3eb8e800', 'I stor grad');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b18-2552-77e9-95a1-366c3eb8e800', 'I noe grad');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b18-2552-77e9-95a1-366c3eb8e800', 'I liten grad');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018e7b18-2552-77e9-95a1-366c3eb8e800', 'Vet ikke');

-- Legg til ny versjon av tema PARTSSAMARBEID
INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, rekkefolge, beskrivelse, introtekst)
VALUES (3, 'UTVIKLE_PARTSSAMARBEID', 1,
        'Utvikle partssamarbeidet i virksomheten',
        'Partssamarbeid er essensielt i virksomheter fordi det bidrar til et godt forebyggende arbeidsmiljø og reduksjon av antall tapte dagsverk. Partssamarbeidet anerkjenner og utnytter kompetansen og ansvarsområdene til verneombud, tillitsvalgte og ledere, noe som skaper en "utvidet ledelseskapasitet".');

-- Legg til alle 7 spørsmål i tema PARTSSAMARBEID
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (3, '018e7b0a-4455-739d-b377-870e01fe978f');

INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (3, '018e7b0b-2490-7295-9ab4-aca881c46320');

INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (3, '018e7b0d-fe32-79ab-8e2e-b990afbbc2bf');

INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (3, '018e7b12-b11a-7f68-b617-e694fd010088');

INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (3, '018e7b15-256d-705e-a3e9-913e56658b28');

INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (3, '018e7b17-4004-7c54-a1ab-d352a87be133');

INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (3, '018e7b18-2552-77e9-95a1-366c3eb8e800');

-- deaktiver gammelt tema PARTSSAMARBEID med temaId 1
UPDATE ia_sak_kartlegging_tema SET status = 'INAKTIV' WHERE tema_id = 1;




