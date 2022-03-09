create table ia_prosess
(
    id              serial primary key,
    orgnr           varchar(20) not null,
    type            varchar not null,
    status          varchar not null,
    opprettet       timestamp default current_timestamp,
    opprettet_av    varchar not null,
    constraint ia_prosess_orgnr_unik unique (orgnr)
);