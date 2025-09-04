-- Rydde i feil fra tidligere migrering i dev-gcp
ALTER TABLE ia_prosess
    DROP COLUMN IF EXISTS offentlig_id;
