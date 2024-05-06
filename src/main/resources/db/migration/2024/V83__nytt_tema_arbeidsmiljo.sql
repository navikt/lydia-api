-- Legg til nytt tema ARBEIDSMILJØ
INSERT INTO ia_sak_kartlegging_tema (tema_id, navn, rekkefolge, beskrivelse, introtekst)
VALUES (6, 'ARBEIDSMILJØ', 3,
        'Arbeidsmiljø',
        '');

-- spm 1
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst)
VALUES ('018f4e7b-5689-7ff7-884f-2635a51009ef', 'Vi er kjent med hva som er de vanlige risikofaktorene for vår bransje');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e7b-5689-7ff7-884f-2635a51009ef', 'Enig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e7b-5689-7ff7-884f-2635a51009ef', 'Litt enig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e7b-5689-7ff7-884f-2635a51009ef', 'Hverken enig eller uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e7b-5689-7ff7-884f-2635a51009ef', 'Litt uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e7b-5689-7ff7-884f-2635a51009ef', 'Uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e7b-5689-7ff7-884f-2635a51009ef', 'Vet ikke');

-- spm 2
INSERT INTO ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst)
VALUES ('018f4e7b-5689-7595-932f-06a4ee599efc', 'Vi jobber systematisk med tiltak for å forbedre arbeidsmiljøet');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e7b-5689-7595-932f-06a4ee599efc', 'Enig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e7b-5689-7595-932f-06a4ee599efc', 'Litt enig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e7b-5689-7595-932f-06a4ee599efc', 'Hverken enig eller uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e7b-5689-7595-932f-06a4ee599efc', 'Litt uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e7b-5689-7595-932f-06a4ee599efc', 'Uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '018f4e7b-5689-7595-932f-06a4ee599efc', 'Vet ikke');


-- Legg til spørsmål i tema ARBEIDSMILJØ
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (6, '018f4e7b-5689-7ff7-884f-2635a51009ef');
INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (6, '018f4e7b-5689-7595-932f-06a4ee599efc');
