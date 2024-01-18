create table ia_sak_kartlegging
(
    kartlegging_id          varchar(36) primary key,
    orgnr                   varchar not null,
    saksnummer              varchar(26) not null,
    status                  varchar(32) not null,
    opprettet_av            varchar not null,
    opprettet               timestamp default current_timestamp,
    endret                  timestamp default null
);
