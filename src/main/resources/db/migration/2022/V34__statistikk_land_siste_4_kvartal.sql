create table sykefravar_statistikk_kategori_siste_4_kvartal
(
    id               serial primary key,
    kategori         varchar(20) not null,
    kode             varchar(20) not null,
    tapte_dagsverk   decimal,
    mulige_dagsverk  decimal,
    prosent          decimal,
    maskert          boolean     not null,
    antall_kvartaler smallint    not null,
    kvartaler        jsonb,
    sist_endret      timestamp default current_timestamp
);

alter table sykefravar_statistikk_kategori_siste_4_kvartal add constraint kategori_og_kode unique (kategori, kode);
