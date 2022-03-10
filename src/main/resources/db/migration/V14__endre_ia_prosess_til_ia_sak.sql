drop table ia_prosess;

create table ia_sak
(
    saksnummer      varchar(20) primary key,
    orgnr           varchar(20) not null,
    type            varchar not null,
    status          varchar not null,
    opprettet_av    varchar not null,
    opprettet       timestamp default current_timestamp,
    endret_av       varchar default null,
    endret          timestamp default null
);

create index idx_ia_sak_orgnr on ia_sak(orgnr);