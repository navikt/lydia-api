alter table virksomhet_metadata rename to virksomhet_statistikk_metadata;
alter table virksomhet_statistikk_metadata drop column navn;

create table virksomhet
(
    id            serial primary key,
    orgnr         varchar  not null,
    land          varchar  not null,
    landkode      varchar  not null,
    postnummer    smallint not null,
    poststed      varchar  not null,
    kommune       varchar  not null,
    kommunenummer varchar  not null
);

create index idx_orgnr_virksomhet on virksomhet(orgnr);
create index idx_orgnr_virksomhet_statistikk_metadata on virksomhet_statistikk_metadata(orgnr);
create index idx_orgnr_sykefravar_statistikk_virksomhet on sykefravar_statistikk_virksomhet(orgnr);