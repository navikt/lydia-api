create table ia_sak_kartlegging_sporsmal
(
    sporsmal_id    varchar(36) primary key,
    sporsmal_tekst varchar not null
);

create table ia_sak_kartlegging_svaralternativer
(
    svaralternativ_id    varchar(36) primary key,
    svaralternativ_tekst varchar not null
);

create table ia_sak_kartlegging_sporsmal_til_kartlegging
(
    id             serial primary key,
    kartlegging_id varchar(36) not null,
    sporsmal_id    varchar(36) not null,
    constraint fk_ia_sak_kartlegging_sporsmal_til_kartlegging_krtlg_id foreign key (kartlegging_id) references ia_sak_kartlegging (kartlegging_id),
    constraint fk_ia_sak_kartlegging_sporsmal_til_kartlegging_spm_id foreign key (sporsmal_id) references ia_sak_kartlegging_sporsmal (sporsmal_id),
    constraint ia_sak_kartlegging_sporsmal_til_kartlegging_krtlg_id_spm_id unique (kartlegging_id, sporsmal_id)
);

create table ia_sak_kartlegging_svaralternativer_til_sporsmal
(
    id                serial primary key,
    sporsmal_id       varchar(36) not null,
    svaralternativ_id varchar(36) not null,
    constraint fk_ia_sak_kartlegging_svaralternativer_til_sporsmal_spm_id foreign key (sporsmal_id) references ia_sak_kartlegging_sporsmal (sporsmal_id),
    constraint fk_ia_sak_kartlegging_svaralternativer_til_sporsmal_svaralt_id foreign key (svaralternativ_id) references ia_sak_kartlegging_svaralternativer (svaralternativ_id),
    constraint ia_sak_kartlegging_svaralternativer_til_sporsmal_spm_svaralt unique (sporsmal_id, svaralternativ_id)
);
