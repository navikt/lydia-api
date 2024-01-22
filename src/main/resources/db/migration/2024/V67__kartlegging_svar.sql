create table ia_sak_kartlegging_svar
(
    id                      serial primary key,
    kartlegging_id          varchar(36) not null,
    sesjon_id               varchar(36) not null,
    sporsmal_id             varchar(36) not null,
    svar_id                 varchar(36) not null,
    opprettet               timestamp default current_timestamp,
    endret                  timestamp default null,
    constraint fk_ia_sak_kartlegging_svar_kartlegging_id foreign key (kartlegging_id) references ia_sak_kartlegging (kartlegging_id)
);

alter table ia_sak_kartlegging_svar add constraint ia_sak_kartlegging_svar_kartlegging_sesjon_spm unique (kartlegging_id, sesjon_id, sporsmal_id);
