ALTER TABLE ia_sak RENAME TO ia_sak_alle;

CREATE VIEW ia_sak AS (
  SELECT * FROM ia_sak_alle WHERE status <> 'SLETTET'
);