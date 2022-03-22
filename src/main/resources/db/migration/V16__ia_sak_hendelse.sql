create table ia_sak_hendelse
(
    id              varchar primary key,
    saksnummer      varchar not null,
    orgnr           varchar(20) not null,
    type            varchar not null,
    opprettet_av    varchar not null,
    opprettet       timestamp default current_timestamp,
    constraint fk_ia_sak_hendelse_sak foreign key (saksnummer) references ia_sak(saksnummer) on delete cascade,
    constraint fk_ia_sak_hendelse_virksomhet foreign key (orgnr) references virksomhet(orgnr),
);

create index idx_ia_sak_hendelse_orgnr on ia_sak_hendelse(orgnr);
create index idx_ia_sak_hendelse_saksnummer on ia_sak_hendelse(saksnummer);


alter table ia_sak
    add column forrige_hendelse_id varchar;
alter table ia_sak
    add constraint fk_ia_sak_forrige_hendelse_id foreign key (forrige_hendelse_id) references ia_sak_hendelse(id);
