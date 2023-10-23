create table sykefravar_statistikk_virksomhet_gradering
(
    id                      serial primary key,
    orgnr                   varchar(20) not null,
    arstall                 smallint    not null,
    kvartal                 smallint    not null,
    antall_personer         decimal     not null,
    tapte_dagsverk_gradert  decimal     not null,
    tapte_dagsverk          decimal     not null,
    prosent                 decimal     not null,
    maskert                 boolean     not null,
    opprettet               timestamp default current_timestamp,
    endret                  timestamp default null
);

alter table sykefravar_statistikk_virksomhet_gradering add constraint virksomhet_gradering_orgnr_arstall_kvartal unique (orgnr, arstall, kvartal);

create index idx_sykefravar_statistikk_virksomhet_gradering_orgnr on sykefravar_statistikk_virksomhet_gradering(orgnr);
create index idx_sykefravar_statistikk_virksomhet_gradering_arstall on sykefravar_statistikk_virksomhet_gradering(arstall);
create index idx_sykefravar_statistikk_virksomhet_gradering_kvartal on sykefravar_statistikk_virksomhet_gradering(kvartal);

create table sykefravar_statistikk_virksomhet_gradering_siste_4_kvartal
(
    id                      serial primary key,
    orgnr                   varchar(20) not null,
    publisert_arstall       smallint    not null,
    publisert_kvartal       smallint    not null,
    tapte_dagsverk_gradert  decimal     not null,
    tapte_dagsverk          decimal     not null,
    prosent                 decimal     not null,
    maskert                 boolean     not null,
    antall_kvartaler        smallint    not null,
    kvartaler               jsonb,
    opprettet               timestamp default current_timestamp,
    endret                  timestamp default null
);

alter table sykefravar_statistikk_virksomhet_gradering_siste_4_kvartal add constraint virksomhet_gradering_4k_orgnr_arstall_kvartal unique (orgnr, publisert_arstall, publisert_kvartal);

create index idx_sykefravar_statistikk_virksomhet_gradering_siste_4k_orgnr on sykefravar_statistikk_virksomhet_gradering_siste_4_kvartal(orgnr);
create index idx_sykefravar_statistikk_virksomhet_gradering_siste_4k_arstall on sykefravar_statistikk_virksomhet_gradering_siste_4_kvartal(publisert_arstall);
create index idx_sykefravar_statistikk_virksomhet_gradering_siste_4k_kvartal on sykefravar_statistikk_virksomhet_gradering_siste_4_kvartal(publisert_kvartal);