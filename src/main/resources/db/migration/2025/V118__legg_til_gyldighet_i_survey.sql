alter table ia_sak_kartlegging add column gyldig_til timestamp default null;
update ia_sak_kartlegging set gyldig_til = opprettet + interval '1' day;
alter table ia_sak_kartlegging alter column gyldig_til set not null