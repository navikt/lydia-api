alter table sykefravar_statistikk_virksomhet
  add constraint sykefravar_periode unique (orgnr, arstall, kvartal);