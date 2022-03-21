create table ia_sak_hendelse
(
    id              varchar primary key,
    saksnummer      varchar not null,
    orgnr           varchar(20) not null,
    type            varchar not null,
    forrige_hendelse_id varchar null,
    opprettet_av    varchar not null,
    opprettet       timestamp default current_timestamp,
    constraint fk_ia_sak_hendelse_sak foreign key (saksnummer) references ia_sak(saksnummer) on delete cascade,
    constraint fk_ia_sak_hendelse_virksomhet foreign key (orgnr) references virksomhet(orgnr),
    constraint fk_ia_sak_hendelse_self foreign key (forrige_hendelse_id) references ia_sak_hendelse(id)
);

create index idx_ia_sak_hendelse_orgnr on ia_sak_hendelse(orgnr);
create index idx_ia_sak_hendelse_saksnummer on ia_sak_hendelse(saksnummer);
