DROP TABLE ia_sak_plan_ressurs;

ALTER TABLE ia_sak_kartlegging
    DROP COLUMN vert_id;

ALTER TABLE ia_sak_kartlegging_tema
    DROP COLUMN navn,
    DROP COLUMN introtekst;

ALTER TABLE ia_sak_kartlegging_tema
    RENAME COLUMN beskrivelse TO navn;
