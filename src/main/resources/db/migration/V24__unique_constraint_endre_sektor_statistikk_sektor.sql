alter table sykefravar_statistikk_sektor
    add constraint sektor_periode unique (sektor_kode, arstall, kvartal);

alter table sykefravar_statistikk_sektor
    alter column sektor_kode type varchar;

create index idx_sektor_kode_sykefravar_statistikk_sektor on sykefravar_statistikk_sektor(sektor_kode);