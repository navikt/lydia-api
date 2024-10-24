alter table ia_sak_kartlegging_tema add column type varchar;

UPDATE ia_sak_kartlegging_tema set type = 'Behovsvurdering';