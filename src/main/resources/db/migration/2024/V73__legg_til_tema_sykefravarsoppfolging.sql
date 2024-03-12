UPDATE ia_sak_kartlegging_tema SET navn = 'UTVIKLE_PARTSSAMARBEID', beskrivelse = 'Utvikle partsamarbeidet i virksomheten'
  WHERE tema_id = 1;
UPDATE ia_sak_kartlegging_tema SET navn = 'REDUSERE_SYKEFRAVÆR', beskrivelse = 'Redusere sykefravær i virksomheten'
  WHERE tema_id = 2;

--- spm 1

insert into ia_sak_kartlegging_sporsmal (sporsmal_id, sporsmal_tekst)
  VALUES ('5df90163-81e4-44c5-8e72-9b47f2added2', 'I hvilken grad jobber dere med tilrettelegging og tilpasning av arbeid?');

insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '5df90163-81e4-44c5-8e72-9b47f2added2', 'I stor grad');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '5df90163-81e4-44c5-8e72-9b47f2added2', 'I noen grad');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '5df90163-81e4-44c5-8e72-9b47f2added2', 'I liten grad');
insert into ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '5df90163-81e4-44c5-8e72-9b47f2added2', 'Vet ikke');

INSERT INTO ia_sak_kartlegging_tema_til_spørsmål (tema_id, sporsmal_id)
VALUES (2, '5df90163-81e4-44c5-8e72-9b47f2added2');