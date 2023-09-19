alter table sykefravar_statistikk_virksomhet_siste_4_kvartal
    add column publisert_kvartal smallint,
    add column publisert_arstall smallint;

update sykefravar_statistikk_virksomhet_siste_4_kvartal set publisert_kvartal = 2, publisert_arstall = 2023;

alter table sykefravar_statistikk_virksomhet_siste_4_kvartal
    alter column publisert_kvartal set not null,
    alter column publisert_arstall set not null,
    drop constraint sykefravar_statistikk_virksomhet_siste_4_kvartal_orgnr_key,
    add unique (orgnr, publisert_kvartal, publisert_arstall);



alter table sykefravar_statistikk_kategori_siste_4_kvartal
    add column publisert_kvartal smallint,
    add column publisert_arstall smallint;

update sykefravar_statistikk_kategori_siste_4_kvartal set publisert_kvartal = 2, publisert_arstall = 2023;

alter table sykefravar_statistikk_kategori_siste_4_kvartal
    alter column publisert_kvartal set not null,
    alter column publisert_arstall set not null,
    drop constraint kategori_og_kode,
    add unique (kategori, kode, publisert_kvartal, publisert_arstall);
