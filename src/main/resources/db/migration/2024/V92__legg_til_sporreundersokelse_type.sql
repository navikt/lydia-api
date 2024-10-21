alter table ia_sak_kartlegging add column type varchar;

UPDATE ia_sak_kartlegging set type = 'Behovsvurdering';