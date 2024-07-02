ALTER TABLE ia_prosess
  ADD COLUMN navn VARCHAR(25) DEFAULT null,
  ADD COLUMN status varchar not null DEFAULT 'AKTIV',
  ADD COLUMN endret_av_hendelse varchar DEFAULT null,
  ADD COLUMN endret_av varchar DEFAULT null,
  ADD COLUMN endret_tidspunkt timestamp default null;