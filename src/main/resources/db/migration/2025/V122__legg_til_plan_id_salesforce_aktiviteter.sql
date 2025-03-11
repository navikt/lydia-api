ALTER TABLE salesforce_aktiviteter ADD COLUMN plan_id varchar;

-- Velger å ikke ha fremmednøkkel til plan, da jeg er usikker på
-- hvor konsekvent SF er med plan og samarbeid. Samt at man i fremtiden kanskje
-- kan registrere aktiviteter uten å ha en plan i SF.


-- UPDATE salesforce_aktiviteter
--   SET plan_id = plan.id
--   FROM (
--     SELECT plan_id AS id, ia_prosess FROM ia_sak_plan
--   ) AS plan
--   WHERE salesforce_aktiviteter.samarbeid = plan.ia_prosess;
--
-- ALTER TABLE salesforce_aktiviteter
--     ALTER COLUMN plan_id SET NOT NULL,
--     ADD CONSTRAINT salesforce_aktiviteter_plan_id_fkey
--     FOREIGN KEY (plan_id) REFERENCES ia_sak_plan (plan_id);