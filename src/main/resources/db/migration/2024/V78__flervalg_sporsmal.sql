alter table ia_sak_kartlegging_sporsmal add column flervalg boolean not null default false;
update ia_sak_kartlegging_sporsmal set flervalg = true where sporsmal_id = '018e7b0d-fe32-79ab-8e2e-b990afbbc2bf';
