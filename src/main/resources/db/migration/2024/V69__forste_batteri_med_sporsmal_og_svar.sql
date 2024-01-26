--- spm 1

insert into ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst)
VALUES ('b16c4b1c-b45e-470d-a1a5-d6f87424d410',
        'Hvilke av disse faktorene tror du har størst innflytelse på sykefraværet der du jobber?');

insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), 'b16c4b1c-b45e-470d-a1a5-d6f87424d410', 'Arbeidsbelastning');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), 'b16c4b1c-b45e-470d-a1a5-d6f87424d410', 'Arbeidstid');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), 'b16c4b1c-b45e-470d-a1a5-d6f87424d410', 'Arbeidsforhold');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), 'b16c4b1c-b45e-470d-a1a5-d6f87424d410', 'Ledelse');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), 'b16c4b1c-b45e-470d-a1a5-d6f87424d410', 'Noe annet');

--- spm 2

insert into ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst)
VALUES ('61a9a84a-949b-4f46-97e5-c9b60e01d433',
        'Velg det tiltaket som du mener best kan bidra til å forebygge sykefraværet');

insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '61a9a84a-949b-4f46-97e5-c9b60e01d433', 'Bedre oppfølging av ansatte');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '61a9a84a-949b-4f46-97e5-c9b60e01d433', 'Tilrettelegging av arbeidsoppgaver');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '61a9a84a-949b-4f46-97e5-c9b60e01d433', 'Kompetanseutvikling');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '61a9a84a-949b-4f46-97e5-c9b60e01d433', 'Helsefremmende aktiviteter');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '61a9a84a-949b-4f46-97e5-c9b60e01d433', 'Noe annet');

--- spm 3

insert into ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst)
VALUES ('62b3a863-cba3-4c92-8c7e-19d8b4688d49',
        'Vi har kunnskap og ferdigheter til å gjennomføre forbedringstiltak i virksomheten (planlegge tiltak, gjennomføre og evaluere måloppnåelse)');

insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '62b3a863-cba3-4c92-8c7e-19d8b4688d49', 'Helt uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '62b3a863-cba3-4c92-8c7e-19d8b4688d49', 'Litt uenig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '62b3a863-cba3-4c92-8c7e-19d8b4688d49', 'Litt enig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '62b3a863-cba3-4c92-8c7e-19d8b4688d49', 'Veldig enig');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '62b3a863-cba3-4c92-8c7e-19d8b4688d49', 'Vet ikke');