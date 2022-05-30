create table sykefravar_statistikk_naring
(
    id              serial      primary key,
    arstall         smallint    not null,
    kvartal         smallint    not null,
    naring          varchar     not null,
    antall_personer decimal     not null,
    tapte_dagsverk  decimal     not null,
    mulige_dagsverk decimal     not null,
    prosent         decimal     not null,
    maskert         boolean     not null,
    opprettet       timestamp   default current_timestamp,
    constraint naring_periode unique (naring, arstall, kvartal)
);
create index idx_naring_sykefravar_statistikk_naring on sykefravar_statistikk_naring(naring);

create table sykefravar_statistikk_naringsundergruppe
(
    id              serial      primary key,
    arstall         smallint    not null,
    kvartal         smallint    not null,
    naringsundergruppe     varchar     not null,
    antall_personer decimal     not null,
    tapte_dagsverk  decimal     not null,
    mulige_dagsverk decimal     not null,
    prosent         decimal     not null,
    maskert         boolean     not null,
    opprettet       timestamp   default current_timestamp,
    constraint naringsundergruppe_periode unique (naringsundergruppe, arstall, kvartal)
);
create index idx_naringsundergruppe_sykefravar_statistikk_naringsundergruppe on sykefravar_statistikk_naringsundergruppe(naringsundergruppe);

create table sykefravar_statistikk_land
(
    id              serial      primary key,
    arstall         smallint    not null,
    kvartal         smallint    not null,
    land            varchar     not null,
    antall_personer decimal     not null,
    tapte_dagsverk  decimal     not null,
    mulige_dagsverk decimal     not null,
    prosent         decimal     not null,
    maskert         boolean     not null,
    opprettet       timestamp   default current_timestamp,
    constraint land_periode unique (land, arstall, kvartal)
);
create index idx_land_sykefravar_statistikk_land on sykefravar_statistikk_land(land);
