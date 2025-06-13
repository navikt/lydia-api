create table dokument_til_publisering
(
    dokument_id        varchar(36) primary key,
    referanse_id       varchar(36) not null,
    type               varchar not null,
    opprettet_av       varchar not null,
    opprettet          timestamp not null default current_timestamp,
    status             varchar(32) not null,
    publisert          timestamp default null
);
