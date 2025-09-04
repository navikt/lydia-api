ALTER TABLE ia_prosess
    ADD COLUMN offentlig_id VARCHAR(36);

UPDATE ia_prosess
SET offentlig_id = gen_random_uuid()
WHERE offentlig_id IS NULL;

ALTER TABLE ia_prosess
    ALTER COLUMN offentlig_id SET NOT NULL;

ALTER TABLE ia_prosess
    ADD CONSTRAINT unik_offentlig_id UNIQUE (offentlig_id);
