create table sykefravar_statistikk_sektor
(
    id              serial primary key,
    arstall         smallint    not null,
    kvartal         smallint    not null,
    sektor_kode     smallint    not null,
    antall_personer decimal     not null,
    tapte_dagsverk  decimal     not null,
    mulige_dagsverk decimal     not null,
    prosent         decimal     not null,
    maskert         boolean     not null,
    opprettet       timestamp default current_timestamp
);
