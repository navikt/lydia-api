ALTER TABLE tilstand_automatisk_oppdatering ADD COLUMN opprettet timestamp not null default current_timestamp;
ALTER TABLE tilstand_automatisk_oppdatering ADD COLUMN sist_endret timestamp not null default current_timestamp;
