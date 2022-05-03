create table sykefravar_statistikk_grunnlag
(
    id                  serial primary key,
    saksnummer          varchar     not null,
    hendelse_id         varchar     not null,
    orgnr               varchar(20) not null,
    arstall             smallint    not null,
    kvartal             smallint    not null,
    antall_personer     decimal     not null,
    tapte_dagsverk      decimal     not null,
    mulige_dagsverk     decimal     not null,
    prosent             decimal     not null,
    maskert             boolean     not null,
    opprettet           timestamp default current_timestamp,

    constraint fk_sykefravar_statistikk_grunnlag_sak foreign key (saksnummer) references ia_sak(saksnummer),
    constraint fk_sykefravar_statistikk_grunnlag_hendelse foreign key (hendelse_id) references ia_sak_hendelse(id)
);

create index idx_sykefravar_statistikk_grunnlag_orgnr on sykefravar_statistikk_grunnlag(orgnr);