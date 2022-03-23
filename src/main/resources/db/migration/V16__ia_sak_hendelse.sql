create table ia_sak_hendelse
(
    id              varchar primary key,
    saksnummer      varchar not null,
    orgnr           varchar(20) not null,
    type            varchar not null,
    opprettet_av    varchar not null,
    opprettet       timestamp default current_timestamp,
    constraint fk_ia_sak_hendelse_virksomhet foreign key (orgnr) references virksomhet(orgnr)
);

create index idx_ia_sak_hendelse_orgnr on ia_sak_hendelse(orgnr);
create index idx_ia_sak_hendelse_saksnummer on ia_sak_hendelse(saksnummer);


alter table ia_sak
    add column endret_av_hendelse varchar;
alter table ia_sak
    add constraint fk_ia_sak_endret_av_hendelse foreign key (endret_av_hendelse) references ia_sak_hendelse(id);
