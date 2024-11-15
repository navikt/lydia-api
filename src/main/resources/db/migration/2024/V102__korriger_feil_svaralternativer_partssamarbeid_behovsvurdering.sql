DELETE
FROM ia_sak_kartlegging_svaralternativer
WHERE sporsmal_id = '01932f63-597d-73c4-976b-723bba329c57';

INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f63-597d-73c4-976b-723bba329c57', 'Svært bra');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f63-597d-73c4-976b-723bba329c57', 'Bra');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f63-597d-73c4-976b-723bba329c57', 'Dårlig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f63-597d-73c4-976b-723bba329c57', 'Svært dårlig');
INSERT INTO ia_sak_kartlegging_svaralternativer (svaralternativ_id, sporsmal_id, svaralternativ_tekst)
VALUES (gen_random_uuid(), '01932f63-597d-73c4-976b-723bba329c57', 'Vet ikke');