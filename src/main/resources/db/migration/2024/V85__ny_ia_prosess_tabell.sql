CREATE TABLE ia_prosess (
  id serial primary key,
  saksnummer varchar(26) not null,
  opprettet timestamp not null default current_timestamp,
  constraint  fk_ia_prosess_saksnummer foreign key (saksnummer) references ia_sak (saksnummer)
);

INSERT INTO ia_prosess (saksnummer) SELECT DISTINCT saksnummer FROM ia_sak_kartlegging;

ALTER TABLE ia_sak_kartlegging ADD COLUMN ia_prosess INT;

UPDATE ia_sak_kartlegging AS isk SET ia_prosess = ip.id FROM ia_prosess AS ip WHERE isk.saksnummer = ip.saksnummer;

ALTER TABLE ia_sak_kartlegging ADD CONSTRAINT fk_ia_sak_kartlegging_prosess FOREIGN KEY (ia_prosess) references ia_prosess (id);

ALTER TABLE ia_sak_kartlegging DROP COLUMN saksnummer;