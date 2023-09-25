create table sykefravar_statistikk_virksomhet
(
    id              serial primary key,
    orgnr           varchar(20) not null,
    arstall         smallint    not null,
    kvartal         smallint    not null,
    antall_personer decimal     not null,
    tapte_dagsverk  decimal     not null,
    mulige_dagsverk decimal     not null,
    prosent         decimal     not null,
    maskert         boolean     not null,
    opprettet       timestamp default current_timestamp
);

create table virksomhet_metadata
(
    id          serial primary key,
    orgnr       varchar not null,
    navn        varchar not null,
    kategori    varchar not null,
    sektor      varchar not null,
    naring_kode varchar not null,
    opprettet   timestamp default current_timestamp
);

create table sektor
(
    kode varchar primary key,
    navn varchar(255) not null
);

create table naring
(
    kode varchar primary key,
    navn varchar(255) not null
);