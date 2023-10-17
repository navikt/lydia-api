create table sykefravar_statistikk_bransje
(
    id              serial      primary key,
    arstall         smallint    not null,
    kvartal         smallint    not null,
    bransje         varchar     not null,
    antall_personer decimal     not null,
    tapte_dagsverk  decimal     not null,
    mulige_dagsverk decimal     not null,
    prosent         decimal     not null,
    maskert         boolean     not null,
    opprettet       timestamp   default current_timestamp,
    constraint bransje_periode unique (bransje, arstall, kvartal)
);
create index idx_bransje_sykefravar_statistikk_bransje on sykefravar_statistikk_bransje(bransje);
