create index idx_ia_sak_status on ia_sak(status);

create index idx_virksomhet_kommunenr on virksomhet(kommunenummer);

create index idx_sykefravar_statistikk_virksomhet_arstall on sykefravar_statistikk_virksomhet(arstall);
create index idx_sykefravar_statistikk_virksomhet_kvartal on sykefravar_statistikk_virksomhet(kvartal);
